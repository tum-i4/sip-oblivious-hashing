#pragma once


#include "llvm/Pass.h"
#include "llvm/IR/Instructions.h"
#include "llvm/IR/IRBuilder.h"


namespace skeleton {

class InputDependencySkeletonPass : public llvm::ModulePass
{
public:
    static char ID;

    InputDependencySkeletonPass()
        : llvm::ModulePass(ID)
    {
    }

    bool runOnModule(llvm::Module& M) override;
    virtual void getAnalysisUsage(llvm::AnalysisUsage& AU) const override;

private:

    bool insertHashBuilder(llvm::IRBuilder<> &builder, llvm::Value *v);
    bool insertHash(llvm::Instruction& I, llvm::Value *v, bool before);
    bool instrumentInst(llvm::Instruction& I);

private:
    llvm::Constant *hashFunc1;
    llvm::Constant *hashFunc2;
    std::vector<llvm::GlobalVariable *> hashPtrs;
};

}

