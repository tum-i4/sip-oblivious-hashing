#pragma once

#include "llvm/Pass.h"

#include <unordered_set>

namespace llvm {
class BasicBlock;
}

namespace oh {

class NonDeterministicBasicBlocksAnalysis : public llvm::ModulePass {
public:
  static char ID;

  NonDeterministicBasicBlocksAnalysis() : llvm::ModulePass(ID) {}

  bool runOnModule(llvm::Module &M) override;
  virtual void getAnalysisUsage(llvm::AnalysisUsage &AU) const override;

public:
  bool is_block_nondeterministic(llvm::BasicBlock *B) const;

public:
  std::unordered_set<llvm::BasicBlock *> non_deterministic_blocks;
};
}
