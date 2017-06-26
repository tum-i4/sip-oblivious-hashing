#include "FunctionCallsPass.h"

#include "NonDeterministicBasicBlocksAnalysis.h"

#include "llvm/Analysis/LoopInfo.h"
#include "llvm/IR/BasicBlock.h"
#include "llvm/IR/Function.h"
#include "llvm/IR/Module.h"
#include "llvm/IR/Instructions.h"
#include "llvm/IR/LegacyPassManager.h"
#include "llvm/IR/InstrTypes.h"

namespace oh {

char FunctionCallsPass::ID = 0;

void FunctionCallsPass::getAnalysisUsage(llvm::AnalysisUsage& AU) const
{
    AU.setPreservesAll();
    AU.addRequired<llvm::LoopInfoWrapperPass>();
    AU.addRequired<NonDeterministicBasicBlocksAnalysis>();
}

bool FunctionCallsPass::runOnModule(llvm::Module& M)
{
    for (auto& F : M) {
        if (F.isDeclaration() || F.isIntrinsic()) {
            continue;
        }

        llvm::LoopInfo& LI = getAnalysis<llvm::LoopInfoWrapperPass>(F).getLoopInfo();
        const auto& NonDetInfo = getAnalysis<NonDeterministicBasicBlocksAnalysis>();
        for (auto& B : F) {
            for (auto& I : B) {
                bool is_in_loop = (LI.getLoopFor(&B) != nullptr);
                bool is_in_non_det_block = NonDetInfo.is_block_nondeterministic(&B);
                if (auto* callInst = llvm::dyn_cast<llvm::CallInst>(&I)) {
                    auto calledF = callInst->getCalledFunction();
                    if (calledF) {
                        if (is_in_loop) {
                            functions_called_in_loop.insert(calledF);
                        }
                        if (is_in_non_det_block) {
                            functions_called_in_non_det_blocks.insert(calledF);
                        }
                    }
                } else if (auto* invokeInst = llvm::dyn_cast<llvm::InvokeInst>(&I)) {
                    auto invokedF = callInst->getCalledFunction();
                    if (invokedF) {
                        if (is_in_loop) {
                            functions_called_in_loop.insert(invokedF);
                        }
                        if (is_in_non_det_block) {
                            functions_called_in_non_det_blocks.insert(invokedF);
                        }
                    }

                }
            }
        }
    }
    return false;
}

bool FunctionCallsPass::is_function_called_in_a_loop(llvm::Function* F) const
{
    return functions_called_in_loop.find(F) != functions_called_in_loop.end();
}

bool FunctionCallsPass::is_function_called_in_non_det_block(llvm::Function* F) const
{
    return functions_called_in_non_det_blocks.find(F) != functions_called_in_non_det_blocks.end();
}

static llvm::RegisterPass<FunctionCallsPass> X("function-call-info","Collects information about function calls");
}
