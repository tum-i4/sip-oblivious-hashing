#include "ObliviousHashInsertion.h"
#include "Utils.h"
#include "NonDeterministicBasicBlocksAnalysis.h"

#include "input-dependency/InputDependencyAnalysis.h"
#include "input-dependency/InputDependentFunctions.h"

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
#include <stdio.h>
#include <stdint.h>

namespace oh {

namespace {

unsigned get_random(unsigned range)
{
    if (range == 0) {
        return 0;
    }
    return rand() % range;
}

// Duplicates functions from hash.c
// PJW Hash
void hash2(uint64_t *hashVar, uint64_t value) {
  uint8_t *key = (uint8_t *)&value;
  uint64_t high = 0;
  for (int i = 0; i < sizeof(value); i++) {
    *hashVar = (*hashVar << 4) + key[i];
    if ((high = *hashVar & 0xF000000000000000))
      *hashVar ^= high >> 56;
    *hashVar &= ~high;
  }
  //printf("H2: %lu %lu\n", value, *hashVar);
}

//CRC Variant
void hash1(uint64_t *hashVar, uint64_t value) {
  uint8_t *key= (uint8_t *)&value;
  uint64_t highorder = 0;
  for (int i = 0; i < sizeof(value); i++) {
    highorder = *hashVar & 0xF800000000000000;
    *hashVar = *hashVar << 5;
    *hashVar ^= highorder >> 59;
    *hashVar ^= key[i];
  }
  //printf("H1: %lu %lu\n", value, *hashVar);
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
    AU.addRequired<input_dependency::InputDependentFunctionsPass>();
    AU.addRequired<NonDeterministicBasicBlocksAnalysis>();
    AU.addRequired<llvm::LoopInfoWrapperPass>();
}

void ObliviousHashInsertionPass::insertHash(llvm::Instruction& I, llvm::Value *v, bool before)
{
    if (v->getType()->isPointerTy()) {
        return;
    }
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
    unsigned index = get_random(num_hash - 1);
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
        insertHash(I, store->getValueOperand(), false);
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
        //builder.SetInsertPoint(I.getParent(), ++builder.GetInsertPoint());
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
    logger = M.getOrInsertFunction("oh_log", logger_type);

    llvm::ArrayRef<llvm::Type*> input_dep_logger_params{llvm::Type::getInt64PtrTy(Ctx), llvm::Type::getInt64Ty(Ctx)};
    llvm::FunctionType* input_dep_logger_type = llvm::FunctionType::get(llvm::Type::getVoidTy(Ctx), input_dep_logger_params, false);
    input_dep_logger = M.getOrInsertFunction("oh_input_dep_log", input_dep_logger_type);
}

void ObliviousHashInsertionPass::setup_hash_values(llvm::Module& M)
{
    llvm::LLVMContext &Ctx = M.getContext();
    // the last hash variable is for computing hashes over non deterministci branches
    for (int i = 0; i < num_hash; i++) {
        hashPtrs.push_back(new llvm::GlobalVariable(M,
                    llvm::Type::getInt64Ty(Ctx),
                    false,
                    llvm::GlobalValue::ExternalLinkage,
                    llvm::ConstantInt::get(llvm::Type::getInt64Ty(Ctx), 0)));
    }
}

void ObliviousHashInsertionPass::process_non_deterministic_block(llvm::BasicBlock* block)
{
    uint64_t hash_value = 0;
    std::vector<llvm::ConstantInt*> constantValues;

    llvm::Value* valueToHash = nullptr;
    llvm::LLVMContext &Ctx = block->getContext();
    llvm::BasicBlock& entry_block = block->getParent()->getEntryBlock();
    auto local_alloca = new llvm::AllocaInst(llvm::Type::getInt64Ty(entry_block.getContext()), 0, 8, "hashVariable");
    auto alloca_pos = entry_block.getInstList().insert(entry_block.begin(), local_alloca);

    auto local_store = new llvm::StoreInst(llvm::ConstantInt::get(llvm::Type::getInt64Ty(Ctx), 0), local_alloca, false, 8);
    if (block == &entry_block) {
        entry_block.getInstList().insertAfter(alloca_pos, local_store);
    } else {
        block->getInstList().insert(block->getFirstInsertionPt(), local_store);
    }

    auto hashVariable = hashPtrs.back();
    for (auto& I : *block) {
        constantValues.clear();
        valueToHash = nullptr;
        if (auto* load = llvm::dyn_cast<llvm::LoadInst>(&I)) {
            valueToHash = load->getOperand(0);
            if (!valueToHash->getType()->isIntegerTy()) {
                continue;
            }
            if (auto constVal = llvm::dyn_cast<llvm::ConstantInt>(valueToHash)) {
                constantValues.push_back(constVal);
            }
        } else if (auto* store = llvm::dyn_cast<llvm::StoreInst>(&I)) {
            if (store->getPointerOperand() == local_alloca) {
                continue;
            }
            valueToHash = store->getValueOperand();
            if (!valueToHash->getType()->isIntegerTy()) {
                continue;
            }
            if (auto constVal = llvm::dyn_cast<llvm::ConstantInt>(valueToHash)) {
                constantValues.push_back(constVal);
            }
        } else if (auto* cmp = llvm::dyn_cast<llvm::ICmpInst>(&I)) {
            valueToHash = cmp->getOperand(1);
            if (!valueToHash->getType()->isIntegerTy()) {
                continue;
            }
            if (auto constVal = llvm::dyn_cast<llvm::ConstantInt>(valueToHash)) {
                constantValues.push_back(constVal);
            }
        } 
        else if (auto* call = llvm::dyn_cast<llvm::CallInst>(&I)) {
            auto calledF = call->getCalledFunction();
            if (calledF == nullptr)  {
                continue;
            }
            if (calledF->getName() == "oh_log"
                || calledF->getName() == "oh_assert"
                || calledF->getName() == "hash1"
                || calledF->getName() == "hash2") {
                continue;
            }
            for (unsigned i = 0; i < call->getNumArgOperands(); ++i) {
                auto arg = call->getArgOperand(i);
                if (!arg->getType()->isIntegerTy()) {
                    continue;
                }
                if (auto constVal = llvm::dyn_cast<llvm::ConstantInt>(arg)) {
                    constantValues.push_back(constVal);
                }
            }
        }
        if (constantValues.empty()) {
            continue;
        }
        llvm::IRBuilder<> l_builder(&I);
        if (I.isTerminator()) {
            // before terminator
            l_builder.SetInsertPoint(&I);
        } else {
            // after
            l_builder.SetInsertPoint(block, ++l_builder.GetInsertPoint());
        }

        for (auto& constantValue : constantValues) {
            if (constantValue == nullptr) {
                continue;
            }
            if (constantValue->getSExtValue() < 0) {
                continue;
            }
            std::vector<llvm::Value*> arg_values;
            arg_values.push_back(local_alloca);
            auto cast = l_builder.CreateZExtOrBitCast(constantValue, llvm::Type::getInt64Ty(Ctx));
            arg_values.push_back(cast);
            llvm::ArrayRef<llvm::Value*> args(arg_values);
            int hashFidx = get_random(2);
            l_builder.CreateCall(hashFidx ? hashFunc1 : hashFunc2, args);
            if (hashFidx) {
                hash1(&hash_value, constantValue->getZExtValue());
            } else {
                hash2(&hash_value, constantValue->getZExtValue());
            }
        }
    }

    llvm::IRBuilder<> builder(block);
    builder.SetInsertPoint(&block->back());
    std::vector<llvm::Value*> arg_values;
    arg_values.push_back(local_alloca);
    arg_values.push_back(llvm::ConstantInt::get(llvm::Type::getInt64Ty(Ctx), hash_value));
    llvm::ArrayRef<llvm::Value*> args(arg_values);
    builder.CreateCall(input_dep_logger, args);
}

void ObliviousHashInsertionPass::process_input_dependent_function(llvm::Function* F)
{
    for (auto& B : *F) {
        process_non_deterministic_block(&B);
    }
}

bool ObliviousHashInsertionPass::runOnModule(llvm::Module& M)
{
    if (num_hash == 0) {
        llvm::dbgs() << "Number of hash variables is not defined. Setting to 1\n";
        num_hash = 1;
    }
    llvm::dbgs() << "Insert hash computation\n";
    bool modified = false;
    unique_id_generator::get().reset();
    srand(time(NULL));

    hashPtrs.reserve(num_hash + 1);
    const auto& input_dependency_info = getAnalysis<input_dependency::InputDependencyAnalysis>();
    const auto& function_calls = getAnalysis<input_dependency::InputDependentFunctionsPass>();
    const auto& non_det_blocks = getAnalysis<NonDeterministicBasicBlocksAnalysis>();
    
    // Get the function to call from our runtime library.
    setup_functions(M);
    // Insert Globals
    setup_hash_values(M);

    for (auto& F : M) {
        // No input dependency info for declarations and instrinsics.
        if (F.isDeclaration() || F.isIntrinsic()) {
            continue;
        }
        // no hashes for functions called from non deterministc blocks
        if (!function_calls.is_function_input_independent(&F)) {
            llvm::dbgs() << "Function called from non-deterministic block " << F.getName() << "\n";
            process_input_dependent_function(&F);
            continue;
        }
        llvm::LoopInfo& LI = getAnalysis<llvm::LoopInfoWrapperPass>(F).getLoopInfo();
        for (auto& B : F) {
            if (non_det_blocks.is_block_nondeterministic(&B) && &F.back() != &B) {
                process_non_deterministic_block(&B);
                continue;
            }
            for (auto& I : B) {
                if (auto phi = llvm::dyn_cast<llvm::PHINode>(&I)) {
                    continue;
                }
                if (auto callInst = llvm::dyn_cast<llvm::CallInst>(&I)) {
                    auto calledF = callInst->getCalledFunction();
                    if (calledF && calledF->getName() == "oh_log") {
                        continue;
                    }
                }
                if (input_dependency_info.isInputDependent(&I)) {
                    //llvm::dbgs() << "D: " << I << "\n";
                } else {
                    //llvm::dbgs() << "I: " << I << "\n";
                    instrumentInst(I);
                    modified = true;
                }
                auto loop = LI.getLoopFor(&B);
                if (loop != nullptr) {
                    continue;
                }
                insertLogger(I);
                modified = true;
            }
        }
    }
    return modified;
}

static llvm::RegisterPass<ObliviousHashInsertionPass> X("oh-insert","Instruments bitcode with hashing and logging functions");

static void registerPathsAnalysisPass(const llvm::PassManagerBuilder &,
                         	      llvm::legacy::PassManagerBase &PM) {
  PM.add(new ObliviousHashInsertionPass());
}

static llvm::RegisterStandardPasses RegisterMyPass(llvm::PassManagerBuilder::EP_EarlyAsPossible, registerPathsAnalysisPass);


}

