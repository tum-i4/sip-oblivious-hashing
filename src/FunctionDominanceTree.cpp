#include "FunctionDominanceTree.h"

#include "llvm/ADT/SCCIterator.h"
#include "llvm/Analysis/CallGraph.h"
#include "llvm/Analysis/CallGraphSCCPass.h"
#include "llvm/IR/Function.h"
#include "llvm/IR/Module.h"
#include "llvm/Support/Debug.h"
#include "llvm/Support/raw_ostream.h"

#include "llvm/IR/LegacyPassManager.h"
#include "llvm/Transforms/IPO/PassManagerBuilder.h"

namespace oh {

FunctionDominanceTree::DomNode::DomNode(llvm::Function *f) : function(f) {}

void FunctionDominanceTree::DomNode::add_dominator(DomNodeT dom) {
  dominators.insert(dom);
}

bool FunctionDominanceTree::DomNode::postdominates(DomNodeT dom) const {
  return dominators.find(dom) != dominators.end();
}

FunctionDominanceTree::DomNode::Dominators &
FunctionDominanceTree::DomNode::get_dominators() {
  return dominators;
}

const FunctionDominanceTree::DomNode::Dominators &
FunctionDominanceTree::DomNode::get_dominators() const {
  return dominators;
}

llvm::Function *FunctionDominanceTree::DomNode::get_function() {
  return function;
}

void FunctionDominanceTree::DomNode::dump() const {
  llvm::dbgs() << "Function: " << function->getName() << "\n";
  for (const auto &caller_node : dominators) {
    llvm::dbgs() << "   Called from: " << caller_node->get_function()->getName()
                 << "\n";
  }
}

void FunctionDominanceTree::add_function(llvm::Function *f, DomNodeT domNode) {
  assert(function_dominators.find(f) == function_dominators.end());
  function_dominators[f] = domNode;
}

FunctionDominanceTree::DomNodeT
FunctionDominanceTree::get_or_create_function_dominance_node(
    llvm::Function *f) {
  auto res =
      function_dominators.insert(std::make_pair(f, DomNodeT(new DomNode(f))));
  return res.first->second;
}

void FunctionDominanceTree::add_function_dominator(llvm::Function *f,
                                                   DomNodeT domNode) {
  auto pos = function_dominators.find(f);
  assert(pos != function_dominators.end());
  pos->second->add_dominator(domNode);
}

FunctionDominanceTree::DomNodeT
FunctionDominanceTree::get_function_dominators(llvm::Function *f) {
  auto pos = function_dominators.find(f);
  if (pos != function_dominators.end()) {
    return pos->second;
  }
  return DomNodeT();
}

const FunctionDominanceTree::DomNodeT
FunctionDominanceTree::get_function_dominators(llvm::Function *f) const {
  auto pos = function_dominators.find(f);
  if (pos != function_dominators.end()) {
    return pos->second;
  }
  return DomNodeT();
}

void FunctionDominanceTree::dump() const {
  for (const auto &function_node : function_dominators) {
    function_node.second->dump();
  }
}

char FunctionDominanceTreePass::ID = 0;

FunctionDominanceTreePass::FunctionDominanceTreePass() : llvm::ModulePass(ID) {}

bool FunctionDominanceTreePass::runOnModule(llvm::Module &M) {
  llvm::CallGraph &CG =
      getAnalysis<llvm::CallGraphWrapperPass>().getCallGraph();
  llvm::scc_iterator<llvm::CallGraph *> CGI = llvm::scc_begin(&CG);
  llvm::CallGraphSCC CurSCC(CG, &CGI);
  while (!CGI.isAtEnd()) {
    const std::vector<llvm::CallGraphNode *> &NodeVec = *CGI;
    CurSCC.initialize(NodeVec.data(), NodeVec.data() + NodeVec.size());
    for (llvm::CallGraphNode *node : CurSCC) {
      llvm::Function *F = node->getFunction();
      if (F == nullptr || F->isDeclaration()) {
        continue;
      }
      auto F_node = dominance_tree.get_or_create_function_dominance_node(F);
      for (auto &callrecord : *node) {
        llvm::Function *calledF = callrecord.second->getFunction();
        if (calledF == nullptr) {
          continue;
        }
        auto called_node =
            dominance_tree.get_or_create_function_dominance_node(calledF);
        called_node->add_dominator(F_node);
      }
    }
    ++CGI;
  }
  // dominance_tree.dump();
  return false;
}

void FunctionDominanceTreePass::getAnalysisUsage(
    llvm::AnalysisUsage &AU) const {
  AU.setPreservesCFG();
  AU.setPreservesAll();
  AU.addRequired<llvm::CallGraphWrapperPass>();
  AU.addPreserved<llvm::CallGraphWrapperPass>();
  AU.setPreservesAll();
}

static llvm::RegisterPass<FunctionDominanceTreePass>
    X("dom-callgraph", "Collects call paths for the given functions");

} // namespace result_checking
