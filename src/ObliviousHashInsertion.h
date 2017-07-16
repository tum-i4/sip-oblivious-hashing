#pragma once


#include "llvm/Pass.h"
#include "llvm/IR/Instructions.h"
#include "llvm/IR/IRBuilder.h"


namespace oh {

class ObliviousHashInsertionPass : public llvm::ModulePass
{
public:
    static char ID;

    ObliviousHashInsertionPass()
        : llvm::ModulePass(ID)
    {
    }

    bool runOnModule(llvm::Module& M) override;
    virtual void getAnalysisUsage(llvm::AnalysisUsage& AU) const override;

private:
    void setup_functions(llvm::Module& M);
    void setup_hash_values(llvm::Module& M);
    void process_non_deterministic_block(llvm::BasicBlock* block);
    void process_input_dependent_function(llvm::Function* F);
    bool insertHashBuilder(llvm::IRBuilder<> &builder, llvm::Value *v);
    void insertHash(llvm::Instruction& I, llvm::Value *v, bool before);
    bool instrumentInst(llvm::Instruction& I);
    void insertLogger(llvm::Instruction& I);
    void insertLogger(llvm::IRBuilder<> &builder, llvm::Instruction& I, unsigned hashToLogIdx);
    void end_logging(llvm::Instruction& I);

private:
    llvm::Constant *hashFunc1;
    llvm::Constant *hashFunc2;
    llvm::Constant *logger;
    llvm::Constant *dummy_logger;
    llvm::Constant *reset;
    // TODO: for debug. delete later
    llvm::Constant *print;
    llvm::GlobalVariable* non_det_hash;
    std::vector<llvm::GlobalVariable *> hashPtrs;
    std::vector<unsigned> usedHashIndices;
};

}

