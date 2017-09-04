#include "FunctionCallsPass.h"

#include "FunctionDominanceTree.h"
#include "input-dependency/IndirectCallSitesAnalysis.h"
#include "input-dependency/InputDependencyAnalysis.h"

#include "llvm/Analysis/LoopInfo.h"
#include "llvm/IR/BasicBlock.h"
#include "llvm/IR/Function.h"
#include "llvm/IR/InstrTypes.h"
#include "llvm/IR/Instructions.h"
#include "llvm/IR/LegacyPassManager.h"
#include "llvm/IR/Module.h"

namespace oh {

char FunctionCallsPass::ID = 0;

void FunctionCallsPass::getAnalysisUsage(llvm::AnalysisUsage &AU) const {
  AU.setPreservesAll();
  AU.addRequired<input_dependency::IndirectCallSitesAnalysis>();
  AU.addRequired<input_dependency::InputDependencyAnalysis>();
  AU.addRequired<FunctionDominanceTreePass>();
}

std::unordered_set<llvm::Function *>
get_call_targets(llvm::CallInst *callInst,
                 const input_dependency::IndirectCallSitesAnalysisResult
                     &indirectCallSitesInfo) {
  std::unordered_set<llvm::Function *> indirectTargets;
  auto calledF = callInst->getCalledFunction();
  if (calledF != nullptr) {
    indirectTargets.insert(calledF);
  } else if (indirectCallSitesInfo.hasIndirectCallTargets(callInst)) {
    indirectTargets = indirectCallSitesInfo.getIndirectCallTargets(callInst);
  }
  return indirectTargets;
}

std::unordered_set<llvm::Function *>
get_invoke_targets(llvm::InvokeInst *callInst,
                   const input_dependency::IndirectCallSitesAnalysisResult
                       &indirectCallSitesInfo) {
  std::unordered_set<llvm::Function *> indirectTargets;
  auto calledF = callInst->getCalledFunction();
  if (calledF != nullptr) {
    indirectTargets.insert(calledF);
  } else if (indirectCallSitesInfo.hasIndirectInvokeTargets(callInst)) {
    indirectTargets = indirectCallSitesInfo.getIndirectInvokeTargets(callInst);
  }
  return indirectTargets;
}

void FunctionCallsPass::process_non_det_block(
    llvm::BasicBlock &block,
    const input_dependency::IndirectCallSitesAnalysisResult
        &indirectCallSitesInfo) {

  std::unordered_set<llvm::Function *> targets;
  for (auto &I : block) {
    targets.clear();
    if (auto *callInst = llvm::dyn_cast<llvm::CallInst>(&I)) {
      targets = get_call_targets(callInst, indirectCallSitesInfo);
    } else if (auto *invokeInst = llvm::dyn_cast<llvm::InvokeInst>(&I)) {
      targets = get_invoke_targets(invokeInst, indirectCallSitesInfo);
    }
    if (!targets.empty()) {
      functions_called_in_non_det_blocks.insert(targets.begin(), targets.end());
    }
  }
}

void FunctionCallsPass::process_call(
    llvm::Function *parentF, const FunctionSet &targets,
    const input_dependency::IndirectCallSitesAnalysisResult
        &indirectCallSitesInfo,
    const input_dependency::InputDependencyAnalysis &inputDepAnalysis,
    const FunctionDominanceTree &domTree, FunctionSet &processed_functions) {
  bool is_non_det_caller = (functions_called_in_non_det_blocks.find(parentF) !=
                            functions_called_in_non_det_blocks.end());
  if (is_non_det_caller) {
    functions_called_in_non_det_blocks.insert(targets.begin(), targets.end());
    return;
  }
  auto domNode = domTree.get_function_dominators(parentF);
  auto &dominators = domNode->get_dominators();
  for (auto &dom : dominators) {
    if (is_non_det_caller) {
      break;
    }
    auto dom_F = dom->get_function();
    if (functions_called_in_non_det_blocks.find(dom_F) !=
        functions_called_in_non_det_blocks.end()) {
      is_non_det_caller = true;
      break;
    } else {
      if (dom_F == parentF) {
        continue;
      }
      process_function(dom_F, indirectCallSitesInfo, inputDepAnalysis, domTree,
                       processed_functions);
      assert(processed_functions.find(dom_F) != processed_functions.end());
      is_non_det_caller = functions_called_in_non_det_blocks.find(dom_F) !=
                          functions_called_in_non_det_blocks.end();
    }
  }
  if (is_non_det_caller) {
    functions_called_in_non_det_blocks.insert(targets.begin(), targets.end());
  }
}

void FunctionCallsPass::process_function(
    llvm::Function *F, const input_dependency::IndirectCallSitesAnalysisResult
                           &indirectCallSitesInfo,
    const input_dependency::InputDependencyAnalysis &inputDepAnalysis,
    const FunctionDominanceTree &domTree, FunctionSet &processed_functions) {
  llvm::dbgs() << "Process function " << F->getName() << "\n";
  if (processed_functions.find(F) != processed_functions.end()) {
    return;
  }
  processed_functions.insert(F);
  for (auto &B : *F) {
    bool is_non_deterministic_block = inputDepAnalysis.isInputDependent(&B);
    if (is_non_deterministic_block) {
      process_non_det_block(B, indirectCallSitesInfo);
      continue;
    }
    for (auto &I : B) {
      if (auto *callInst = llvm::dyn_cast<llvm::CallInst>(&I)) {
        process_call(F, get_call_targets(callInst, indirectCallSitesInfo),
                     indirectCallSitesInfo, inputDepAnalysis, domTree,
                     processed_functions);
      } else if (auto *invokeInst = llvm::dyn_cast<llvm::InvokeInst>(&I)) {
        process_call(F, get_invoke_targets(invokeInst, indirectCallSitesInfo),
                     indirectCallSitesInfo, inputDepAnalysis, domTree,
                     processed_functions);
      }
    }
  }
}

bool FunctionCallsPass::runOnModule(llvm::Module &M) {
  const auto &inputDepAnalysis =
      getAnalysis<input_dependency::InputDependencyAnalysis>();
  const auto &domTree =
      getAnalysis<FunctionDominanceTreePass>().get_dominance_tree();
  std::unordered_set<llvm::Function *> processed_functions;
  for (auto &F : M) {
    if (F.isDeclaration() || F.isIntrinsic()) {
      continue;
    }
    const auto &indirectCallAnalysis =
        getAnalysis<input_dependency::IndirectCallSitesAnalysis>();
    const auto &indirectCallSitesInfo =
        indirectCallAnalysis.getIndirectsAnalysisResult();
    process_function(&F, indirectCallSitesInfo, inputDepAnalysis, domTree,
                     processed_functions);
  }
  for (const auto &f : functions_called_in_non_det_blocks) {
    llvm::dbgs() << "Function is called from non-det block " << f->getName()
                 << "\n";
  }
  return false;
}

bool FunctionCallsPass::is_function_called_in_a_loop(llvm::Function *F) const {
  return functions_called_in_loop.find(F) != functions_called_in_loop.end();
}

bool FunctionCallsPass::is_function_called_in_non_det_block(
    llvm::Function *F) const {
  return functions_called_in_non_det_blocks.find(F) !=
         functions_called_in_non_det_blocks.end();
}

static llvm::RegisterPass<FunctionCallsPass>
    X("function-call-info", "Collects information about function calls");
}
