#pragma once

#include "llvm/Pass.h"
#include "llvm/IR/IRBuilder.h"

namespace llvm {
class CallInst;
class Constant;
class LLVMContext;
}

namespace oh {

class AssertionInsertionPass : public llvm::ModulePass
{
public:
    static char ID;

    AssertionInsertionPass()
        : llvm::ModulePass(ID)
    {
    }

public:
    bool runOnModule(llvm::Module& M) override;

private:
    void parse_hashes();
    void setup_assert_function(llvm::Module& M);
    void process_log_call(llvm::CallInst* log_call);

private:
    std::vector<uint64_t> hashes;
    llvm::Constant* assert;
};

}

