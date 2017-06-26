#pragma once

#include "llvm/Pass.h"

#include <unordered_set>

namespace llvm {
class Function;
}

namespace oh {

class FunctionCallsPass : public llvm::ModulePass
{
public:
   static char ID;
   
   FunctionCallsPass()
        : llvm::ModulePass(ID)
   {
   }

public:
    void getAnalysisUsage(llvm::AnalysisUsage& AU) const override;
    bool runOnModule(llvm::Module& M) override;

public:
    bool is_function_called_in_a_loop(llvm::Function* F) const;
    bool is_function_called_in_non_det_block(llvm::Function* F) const;

private:
    std::unordered_set<llvm::Function*> functions_called_in_loop;
    std::unordered_set<llvm::Function*> functions_called_in_non_det_blocks;
};

}

