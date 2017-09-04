#pragma once

#include "llvm/Pass.h"

#include <memory>
#include <unordered_map>
#include <unordered_set>

namespace llvm {
class Function;
class Module;
}

namespace oh {

class FunctionDominanceTree {
public:
  class DomNode;
  using DomNodeT = std::shared_ptr<DomNode>;

  class DomNode {
  public:
    using Dominators = std::unordered_set<DomNodeT>;

  public:
    DomNode(llvm::Function *f);

  public:
    void add_dominator(DomNodeT dom);
    bool postdominates(DomNodeT dom) const;

    Dominators &get_dominators();
    const Dominators &get_dominators() const;
    llvm::Function *get_function();

    void dump() const;

  private:
    llvm::Function *function;
    //  functions calling current function
    Dominators dominators;
  };

public:
  FunctionDominanceTree() = default;

  FunctionDominanceTree(const FunctionDominanceTree &) = delete;
  FunctionDominanceTree &operator=(const FunctionDominanceTree &) = delete;

public:
  void add_function(llvm::Function *, DomNodeT doms);
  DomNodeT get_or_create_function_dominance_node(llvm::Function *f);
  void add_function_dominator(llvm::Function *f, DomNodeT domNode);
  DomNodeT get_function_dominators(llvm::Function *f);
  const DomNodeT get_function_dominators(llvm::Function *f) const;

  void dump() const;

private:
  std::unordered_map<llvm::Function *, DomNodeT> function_dominators;
};

class FunctionDominanceTreePass : public llvm::ModulePass {
public:
  static char ID;

  FunctionDominanceTreePass();

public:
  void getAnalysisUsage(llvm::AnalysisUsage &AU) const override;
  bool runOnModule(llvm::Module &M) override;

public:
  const FunctionDominanceTree &get_dominance_tree() const {
    return dominance_tree;
  }

  FunctionDominanceTree &get_dominance_tree() { return dominance_tree; }

private:
  FunctionDominanceTree dominance_tree;
};
}
