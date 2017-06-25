#include "ObliviousHashInsertion.h"

#include "Utils.h"

#include "input-dependency/InputDependencyAnalysis.h"

#include "llvm/IR/BasicBlock.h"
#include "llvm/IR/Function.h"
#include "llvm/IR/Module.h"
#include "llvm/IR/Instructions.h"
#include "llvm/IR/LegacyPassManager.h"
#include "llvm/IR/InstrTypes.h"
#include "llvm/Analysis/LoopInfo.h"

#include "llvm/Transforms/IPO/PassManagerBuilder.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/Support/Debug.h"
#include "llvm/Support/Casting.h"
#include "llvm/IR/Constants.h"
#include "llvm/IR/IRBuilder.h"

#include <assert.h>
#include <cstdlib>
#include <ctime>

namespace oh {

namespace {

unsigned get_random(unsigned range)
{
    return rand() % range;
}

}

char ObliviousHashInsertionPass::ID = 0;
static llvm::cl::opt<unsigned> num_hash("num-hash",
                                        llvm::cl::desc("Specify number of hash values to use"),
                                        llvm::cl::value_desc("num_hash"));

void ObliviousHashInsertionPass::getAnalysisUsage(llvm::AnalysisUsage& AU) const
{
    AU.setPreservesAll();
    AU.addRequired<input_dependency::InputDependencyAnalysis>();
    AU.addRequired<llvm::LoopInfoWrapperPass>();
}


bool ObliviousHashInsertionPass::insertHash(llvm::Instruction& I, llvm::Value *v, bool before)
{
    llvm::LLVMContext &Ctx = I.getModule()->getContext();
    llvm::IRBuilder<> builder(&I);
    if (before)
        builder.SetInsertPoint(I.getParent(), builder.GetInsertPoint());
    else
        builder.SetInsertPoint(I.getParent(), ++builder.GetInsertPoint());
    insertHashBuilder(builder, v);
}

bool ObliviousHashInsertionPass::insertHashBuilder(llvm::IRBuilder<> &builder, llvm::Value *v)
{
    llvm::LLVMContext &Ctx = builder.getContext();
    llvm::Value *cast;

    if (v->getType()->isIntegerTy())
        cast = builder.CreateZExtOrBitCast(v, llvm::Type::getInt64Ty(Ctx));
    else if (v->getType()->isPtrOrPtrVectorTy())
        return false;
    else if (v->getType()->isFloatingPointTy())
        cast = builder.CreateFPToSI(v, llvm::Type::getInt64Ty(Ctx));
    else
        assert(false);

    std::vector<llvm::Value*> arg_values;
    unsigned index = get_random(num_hash);
    usedHashIndices.push_back(index);
    arg_values.push_back(hashPtrs.at(index));
    arg_values.push_back(cast);
    llvm::ArrayRef<llvm::Value*> args(arg_values);
    builder.CreateCall(get_random(2) ? hashFunc1 : hashFunc2, args);
    return true;
}

bool ObliviousHashInsertionPass::instrumentInst(llvm::Instruction& I)
{
    if (llvm::CmpInst::classof(&I)) {
	auto *cmp = llvm::dyn_cast<llvm::CmpInst>(&I);
        llvm::LLVMContext &Ctx = I.getModule()->getContext();
        llvm::IRBuilder<> builder(&I);
        builder.SetInsertPoint(I.getParent(), ++builder.GetInsertPoint());
        
        // Insert the transformation of the cmp output into something more usable by the hash function.
        llvm::Value *cmpExt = builder.CreateZExtOrBitCast(cmp, llvm::Type::getInt8Ty(Ctx));
        llvm::Value *val = builder.CreateAdd(
            builder.CreateMul(
                llvm::ConstantInt::get(llvm::Type::getInt8Ty(Ctx), 64), 
                builder.CreateAdd(
                    cmpExt,
                    llvm::ConstantInt::get(llvm::Type::getInt8Ty(Ctx), 1)
                )
            ),
            llvm::ConstantInt::get(llvm::Type::getInt8Ty(Ctx), cmp->getPredicate()));
        insertHashBuilder(builder, val);
    }
    if (llvm::ReturnInst::classof(&I)) {
	auto *ret = llvm::dyn_cast<llvm::ReturnInst>(&I);
	auto *val = ret->getReturnValue();
	if (val) {
            insertHash(I, val, true);
        }
    }
    if (llvm::LoadInst::classof(&I)) {
	auto *load = llvm::dyn_cast<llvm::LoadInst>(&I);
        insertHash(I, load, false);
    }
    if (llvm::StoreInst::classof(&I)) {
	auto *store = llvm::dyn_cast<llvm::StoreInst>(&I);
        insertHash(I, store->getValueOperand(), true);
    }
    if (llvm::BinaryOperator::classof(&I)) {
        auto *bin = llvm::dyn_cast<llvm::BinaryOperator>(&I);
        if (bin->getOpcode() == llvm::Instruction::Add) {
            insertHash(I, bin, false);
        }
    }
    /*if (llvm::AtomicRMWInst::classof(&I)) {
	auto *armw = llvm::dyn_cast<llvm::AtomicRMWInst>(&I);
	llvm::dbgs() << "rmw: ";
	armw->getValOperand()->getType()->print(llvm::dbgs());
	llvm::dbgs() << "\n";
    }*/
}

void ObliviousHashInsertionPass::insertLogger(llvm::Instruction& I)
{
    // no hashing has been done. no meaning to log
    if (usedHashIndices.empty()) {
        return;
    }
    llvm::LLVMContext &Ctx = I.getModule()->getContext();
    llvm::IRBuilder<> builder(&I);
    builder.SetInsertPoint(I.getParent(), builder.GetInsertPoint());

    // logger for cmp instruction should have been added
    if (llvm::CmpInst::classof(&I)) {
        // log the last value which contains hash for this cmp instruction
        builder.SetInsertPoint(I.getParent(), ++builder.GetInsertPoint());
        insertLogger(builder, I, usedHashIndices.back());
        return;
    }

    unsigned random_hash_idx = usedHashIndices.at(get_random(usedHashIndices.size()));
    assert(random_hash_idx < hashPtrs.size());
    if (auto callInst = llvm::dyn_cast<llvm::CallInst>(&I)) {
        auto called_function = callInst->getCalledFunction();
        if (called_function != nullptr
                && !called_function->isIntrinsic()
                && called_function != hashFunc1
                && called_function != hashFunc2) {
            // always insert logger before call instructions
            insertLogger(builder, I, random_hash_idx);
            return;
        }
    }
    if (get_random(2)) {
        // insert randomly
        insertLogger(builder, I, random_hash_idx);
    }
}

void ObliviousHashInsertionPass::insertLogger(llvm::IRBuilder<> &builder, llvm::Instruction& instr, unsigned hashToLogIdx)
{
    builder.SetInsertPoint(instr.getParent(), builder.GetInsertPoint());
    llvm::LLVMContext& Ctx = builder.getContext();

    std::vector<llvm::Value*> arg_values;
    unsigned id = unique_id_generator::get().next();
    //llvm::dbgs() << "ID  " << id << " for instruction " << instr << "\n";
    llvm::Value* id_value = llvm::ConstantInt::get(llvm::Type::getInt32Ty(Ctx), id);
    arg_values.push_back(id_value);
    arg_values.push_back(hashPtrs.at(hashToLogIdx));
    llvm::ArrayRef<llvm::Value*> args(arg_values);
    builder.CreateCall(logger, args);
}

void ObliviousHashInsertionPass::end_logging(llvm::Instruction& I)
{
    llvm::LLVMContext& Ctx = I.getParent()->getParent()->getContext();
    llvm::IRBuilder<> builder(&I);
    builder.SetInsertPoint(I.getParent(), builder.GetInsertPoint());

    std::vector<llvm::Value*> arg_values;
    llvm::Value* zero_val = llvm::ConstantInt::get(llvm::Type::getInt32Ty(Ctx), 0);
    arg_values.push_back(zero_val);
    arg_values.push_back(llvm::ConstantPointerNull::get(llvm::Type::getInt64PtrTy(Ctx)));
    llvm::ArrayRef<llvm::Value*> args(arg_values);
    builder.CreateCall(logger, args);
}

void ObliviousHashInsertionPass::setup_functions(llvm::Module& M)
{
    llvm::LLVMContext &Ctx = M.getContext();
    llvm::ArrayRef<llvm::Type*> params{llvm::Type::getInt64PtrTy(Ctx), llvm::Type::getInt64Ty(Ctx)};
    llvm::FunctionType* function_type = llvm::FunctionType::get(llvm::Type::getVoidTy(Ctx), params, false);
    hashFunc1 = M.getOrInsertFunction("hash1", function_type);
    hashFunc2 = M.getOrInsertFunction("hash2", function_type);

    // arguments of logger are line and column number of instruction and hash variable to log
    llvm::ArrayRef<llvm::Type*> logger_params{llvm::Type::getInt32Ty(Ctx), llvm::Type::getInt64PtrTy(Ctx)};
    llvm::FunctionType* logger_type = llvm::FunctionType::get(llvm::Type::getVoidTy(Ctx), logger_params, false);
    logger = M.getOrInsertFunction("log", logger_type);
}

void ObliviousHashInsertionPass::setup_hash_values(llvm::Module& M)
{
    llvm::LLVMContext &Ctx = M.getContext();
    for (int i = 0; i < num_hash; i++) {
        hashPtrs.push_back(new llvm::GlobalVariable(M,
                    llvm::Type::getInt64Ty(Ctx),
                    false,
                    llvm::GlobalValue::ExternalLinkage,
                    llvm::ConstantInt::get(llvm::Type::getInt64Ty(Ctx), 0)));
    }
}

bool ObliviousHashInsertionPass::runOnModule(llvm::Module& M)
{
    llvm::dbgs() << "Insert hash computation\n";
    unique_id_generator::get().reset();
    srand(time(NULL));

    hashPtrs.reserve(num_hash);
    const auto& input_dependency_info = getAnalysis<input_dependency::InputDependencyAnalysis>();
    
    // Get the function to call from our runtime library.
    setup_functions(M);
    // Insert Globals
    setup_hash_values(M);

    llvm::Instruction* last_instr;
    for (auto& F : M) {
        // No input dependency info for declarations and instrinsics.
        if (F.isDeclaration() || F.isIntrinsic()) {
            continue;
        }
        llvm::LoopInfo& LI = getAnalysis<llvm::LoopInfoWrapperPass>(F).getLoopInfo();
        llvm::dbgs() << F.getName() << "\n";
        for (auto& B : F) {
            for (auto& I : B) {
                if (input_dependency_info.isInputDependent(&I)) {
                    llvm::dbgs() << "D: " << I << "\n";
                } else {
                    last_instr = &I;
                    llvm::dbgs() << "I: " << I << "\n";
                    instrumentInst(I);
                }
                // no logging inside a loop
                if (LI.getLoopFor(&B) == nullptr) {
                    insertLogger(I);
                }
            }
        }
    }
    end_logging(*last_instr);
    return false;
}

static llvm::RegisterPass<ObliviousHashInsertionPass> X("oh-insert","Instruments bitcode with hashing and logging functions");

static void registerPathsAnalysisPass(const llvm::PassManagerBuilder &,
                         	      llvm::legacy::PassManagerBase &PM) {
  PM.add(new ObliviousHashInsertionPass());
}

static llvm::RegisterStandardPasses RegisterMyPass(llvm::PassManagerBuilder::EP_EarlyAsPossible, registerPathsAnalysisPass);


}

