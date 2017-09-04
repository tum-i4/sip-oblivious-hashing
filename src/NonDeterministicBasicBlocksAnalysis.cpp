#include "NonDeterministicBasicBlocksAnalysis.h"

#include "input-dependency/InputDependencyAnalysis.h"

#include "llvm/Analysis/PostDominators.h"
#include "llvm/IR/BasicBlock.h"
#include "llvm/IR/Function.h"
#include "llvm/IR/InstrTypes.h"
#include "llvm/IR/Instructions.h"
#include "llvm/IR/LegacyPassManager.h"
#include "llvm/IR/Module.h"

namespace oh {

char NonDeterministicBasicBlocksAnalysis::ID = 0;

void NonDeterministicBasicBlocksAnalysis::getAnalysisUsage(
    llvm::AnalysisUsage &AU) const {
  AU.setPreservesAll();
  AU.addRequired<llvm::PostDominatorTreeWrapperPass>();
  AU.addRequired<input_dependency::InputDependencyAnalysis>();
}

bool NonDeterministicBasicBlocksAnalysis::runOnModule(llvm::Module &M) {
  const auto &input_dependency_info =
      getAnalysis<input_dependency::InputDependencyAnalysis>();
  for (auto &F : M) {
    if (F.isDeclaration() || F.isIntrinsic()) {
      continue;
    }
    const auto &postDomTree =
        getAnalysis<llvm::PostDominatorTreeWrapperPass>(F).getPostDomTree();
    for (auto &B : F) {
      auto pred = pred_begin(&B);
      bool is_non_det = false;
      const auto &b_node = postDomTree[&B];
      bool postdominates_all_predecessors = true;
      while (pred != pred_end(&B)) {
        auto pb = *pred;
        const auto &termInstr = pb->getTerminator();
        auto pred_node = postDomTree[pb];
        postdominates_all_predecessors &=
            postDomTree.dominates(b_node, pred_node);
        if (termInstr != nullptr) {
          is_non_det |= input_dependency_info.isInputDependent(termInstr);
        }
        ++pred;
      }
      if (is_non_det) {
        non_deterministic_blocks.insert(&B);
        // if (!postdominates_all_predecessors) {
        //    non_deterministic_blocks.insert(&B);
        //} else if (loop != nullptr) {
        //    // header always dominates predecessors, doesn't mean it is
        //    deterministic
        //    non_deterministic_blocks.insert(&B);
        //}
      }
    }
  }
  return false;
}

bool NonDeterministicBasicBlocksAnalysis::is_block_nondeterministic(
    llvm::BasicBlock *B) const {
  return non_deterministic_blocks.find(B) != non_deterministic_blocks.end();
}

static llvm::RegisterPass<NonDeterministicBasicBlocksAnalysis>
    X("nondet-blocks", "Finds blocks which are non deterministc");
}
