#pragma once

#include "llvm/Pass.h"

#include <unordered_set>

namespace llvm {
class Function;
class BasicBlock;
}

namespace input_dependency {
class IndirectCallSitesAnalysisResult;
class InputDependencyAnalysis;
}

namespace oh {

class FunctionDominanceTree;

class FunctionCallsPass : public llvm::ModulePass {
public:
  static char ID;

  FunctionCallsPass() : llvm::ModulePass(ID) {}

public:
  void getAnalysisUsage(llvm::AnalysisUsage &AU) const override;
  bool runOnModule(llvm::Module &M) override;

public:
  bool is_function_called_in_a_loop(llvm::Function *F) const;
  bool is_function_called_in_non_det_block(llvm::Function *F) const;

private:
  using FunctionSet = std::unordered_set<llvm::Function *>;

  void
  process_non_det_block(llvm::BasicBlock &block,
                        const input_dependency::IndirectCallSitesAnalysisResult
                            &indirectCallSitesInfo);
  void process_function(
      llvm::Function *F, const input_dependency::IndirectCallSitesAnalysisResult
                             &indirectCallSitesInfo,
      const input_dependency::InputDependencyAnalysis &inputDepAnalysis,
      const FunctionDominanceTree &domTree, FunctionSet &processed_function);
  void process_call(
      llvm::Function *parentF, const FunctionSet &targets,
      const input_dependency::IndirectCallSitesAnalysisResult
          &indirectCallSitesInfo,
      const input_dependency::InputDependencyAnalysis &inputDepAnalysis,
      const FunctionDominanceTree &domTree, FunctionSet &processed_functions);

private:
  FunctionSet functions_called_in_loop;
  FunctionSet functions_called_in_non_det_blocks;
};
}
