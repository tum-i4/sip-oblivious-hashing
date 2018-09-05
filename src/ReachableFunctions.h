#pragma once

#include "llvm/Pass.h"

#include <unordered_map>
#include <unordered_set>

namespace llvm {
class CallGraph;
class CallGraphNode;
class Function;
class FunctionType;
class Module;
}

namespace oh {

class ReachableFunctions
{
public:
    using FunctionSet = std::unordered_set<llvm::Function*>;
    using FunctionTypeMap = std::unordered_map<llvm::FunctionType*, FunctionSet>;

public:
    ReachableFunctions(llvm::Module* M,
                       llvm::CallGraph* cfg);

    ReachableFunctions(const ReachableFunctions& ) = delete;
    ReachableFunctions(ReachableFunctions&& ) = delete;
    ReachableFunctions& operator =(const ReachableFunctions& ) = delete;
    ReachableFunctions& operator =(ReachableFunctions&& ) = delete;

public:
    FunctionSet getReachableFunctions(llvm::Function* F);
    
private:
    FunctionTypeMap collect_function_types();
    void collect_reachable_functions(llvm::CallGraphNode* callNode,
                                     FunctionSet& reachable_functions);
    void collect_indirectly_reachable_functions(FunctionSet& reachable_functions,
                                                const FunctionTypeMap& functionTypes);
    FunctionSet collect_indirectly_called_functions(llvm::Function* F,
                                                    const FunctionTypeMap& functionTypes);
       
    template <typename CallType>
    FunctionSet get_indirect_called_functions(CallType* callInst,
                                              const FunctionTypeMap& functionTypes);
    template <typename CallType>
    FunctionSet get_functions_from_arguments(CallType* callInst,
                                             const FunctionTypeMap& functionTypes);

private:
    llvm::Module* m_module;
    llvm::CallGraph* m_callGraph;
};

class ReachableFunctionsPass : public llvm::ModulePass
{
public:
  static char ID;

  ReachableFunctionsPass()
      : llvm::ModulePass(ID)
  {}

  bool runOnModule(llvm::Module &M) override;
  virtual void getAnalysisUsage(llvm::AnalysisUsage &AU) const override;

};

}

