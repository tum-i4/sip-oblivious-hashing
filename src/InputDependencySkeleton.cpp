#include "InputDependencySkeleton.h"

#include "input-dependency/InputDependencyAnalysis.h"

#include "llvm/IR/BasicBlock.h"
#include "llvm/IR/Function.h"
#include "llvm/IR/Module.h"
#include "llvm/IR/Instructions.h"
#include "llvm/IR/LegacyPassManager.h"
#include "llvm/IR/InstrTypes.h"

#include "llvm/Transforms/IPO/PassManagerBuilder.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/Support/Debug.h"
#include "llvm/Support/Casting.h"
#include "llvm/IR/Constants.h"
#include "llvm/IR/IRBuilder.h"

#include <assert.h>

namespace skeleton {

char InputDependencySkeletonPass::ID = 0;

void InputDependencySkeletonPass::getAnalysisUsage(llvm::AnalysisUsage& AU) const
{
    AU.setPreservesAll();
    AU.addRequired<input_dependency::InputDependencyAnalysis>();
}


bool InputDependencySkeletonPass::insertHash(llvm::Instruction& I, llvm::Value *v, bool before)
{
    llvm::LLVMContext &Ctx = I.getModule()->getContext();
    llvm::IRBuilder<> builder(&I);
    if (before)
        builder.SetInsertPoint(I.getParent(), builder.GetInsertPoint());
    else
        builder.SetInsertPoint(I.getParent(), ++builder.GetInsertPoint());
    insertHashBuilder(builder, v);
}

bool InputDependencySkeletonPass::insertHashBuilder(llvm::IRBuilder<> &builder, llvm::Value *v)
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
    arg_values.push_back(hashPtr);
    arg_values.push_back(cast);
    llvm::ArrayRef<llvm::Value*> args(arg_values);
    builder.CreateCall(hashFunc2, args);
    return true;
}

bool InputDependencySkeletonPass::instrumentInst(llvm::Instruction& I)
{
    //llvm::dbgs() << "--- Instruction: " << I.getOpcodeName() << "\n";
    if (llvm::BranchInst::classof(&I)) {
	auto *br = llvm::dyn_cast<llvm::BranchInst>(&I);
	//if (br->isConditional())
	//    br->getCondition()->print(llvm::dbgs());
	//llvm::dbgs() << "\n";
	    //llvm::dbgs() << "\tCondition: " << br->getCondition() << "\n";
    }
    if (llvm::CmpInst::classof(&I)) {
	auto *cmp = llvm::dyn_cast<llvm::CmpInst>(&I);
        llvm::LLVMContext &Ctx = I.getModule()->getContext();
        llvm::IRBuilder<> builder(&I);
        builder.SetInsertPoint(I.getParent(), ++builder.GetInsertPoint());
        
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
	llvm::dbgs() << "Ret: ";
	if (val) {
	    val->getType()->print(llvm::dbgs());
            //insertHash(I, val, true);
        }
	llvm::dbgs() << "\n";
    }
    if (llvm::LoadInst::classof(&I)) {
	auto *load = llvm::dyn_cast<llvm::LoadInst>(&I);
        llvm::dbgs() << I << "\n";
	llvm::dbgs() << "load: ";
	load->getPointerOperand()->getType()->print(llvm::dbgs());
        //insertHash(I, load, false);
	llvm::dbgs() << "\n";
    }
    if (llvm::StoreInst::classof(&I)) {
	auto *store = llvm::dyn_cast<llvm::StoreInst>(&I);
        llvm::dbgs() << I << "\n";
	llvm::dbgs() << "store: ";
	store->getValueOperand()->getType()->print(llvm::dbgs());
	llvm::dbgs() << "\n";
        //insertHash(I, store->getValueOperand(), true);
    }
    if (llvm::AtomicRMWInst::classof(&I)) {
	auto *armw = llvm::dyn_cast<llvm::AtomicRMWInst>(&I);
	llvm::dbgs() << "rmw: ";
	armw->getValOperand()->getType()->print(llvm::dbgs());
	llvm::dbgs() << "\n";
    }

}

bool InputDependencySkeletonPass::runOnModule(llvm::Module& M)
{
    const auto& input_dependency_info = getAnalysis<input_dependency::InputDependencyAnalysis>();
    
    // Get the function to call from our runtime library.
    llvm::LLVMContext &Ctx = M.getContext();
    llvm::ArrayRef<llvm::Type*> params{llvm::Type::getInt64PtrTy(Ctx), llvm::Type::getInt64Ty(Ctx)};
    //llvm::ArrayRef<llvm::Type*> params{llvm::Type::getInt64PtrTy(Ctx), llvm::Type::getInt8PtrTy(Ctx), llvm::Type::getInt32Ty(Ctx)};
    llvm::FunctionType* function_type = llvm::FunctionType::get(llvm::Type::getVoidTy(Ctx), params, false);
    //hashFunc1 = M.getOrInsertFunction("hash1", function_type);
    hashFunc1 = M.getOrInsertFunction("hash1", llvm::Type::getVoidTy(Ctx), NULL);
    //hashFunc1 = M.getOrInsertFunction("hash1", llvm::Type::getVoidTy(Ctx), llvm::Type::getInt64PtrTy(Ctx), llvm::Type::getInt64Ty(Ctx), NULL);
    hashFunc2 = M.getOrInsertFunction("hash2", function_type);

    // Insert Globals
    hashPtr = new llvm::GlobalVariable(M,
                                                             llvm::Type::getInt64Ty(Ctx),
                                                             false,
                                                             llvm::GlobalValue::ExternalLinkage,
                                                             llvm::ConstantInt::get(llvm::Type::getInt64Ty(Ctx), 0));

    for (auto& F : M) {
        // No input dependency info for declarations.
        if (F.isDeclaration()) {
            continue;
        }
        for (auto& B : F) {
            for (auto& I : B) {
                if (input_dependency_info.isInputDependent(&I)) {
                    //llvm::dbgs() << "Instruction: " << I << " is input dependent\n";
                }
                else {
                    instrumentInst(I);
                }
            }
        }
    }
    return false;
}

static llvm::RegisterPass<InputDependencySkeletonPass> X("input-dep-skeleton","Reports input dependent instructions in bitcode");

static void registerPathsAnalysisPass(const llvm::PassManagerBuilder &,
                         	      llvm::legacy::PassManagerBase &PM) {
  PM.add(new InputDependencySkeletonPass());
}

static llvm::RegisterStandardPasses RegisterMyPass(llvm::PassManagerBuilder::EP_EarlyAsPossible, registerPathsAnalysisPass);


}

