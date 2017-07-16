#pragma once

#include "llvm/Pass.h"
#include "llvm/IR/IRBuilder.h"

#include <unordered_set>

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
    void process_dummy_log_call(llvm::CallInst* log_call);
    void process_dummy_log(llvm::CallInst* callInst);

private:
    using hash_value_set = std::unordered_set<uint64_t>;
    std::vector<hash_value_set> hashes;
    llvm::Constant* assert;
};

}

