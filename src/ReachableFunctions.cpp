#include "ReachableFunctions.h"

#include "llvm/Analysis/CallGraph.h"
#include "llvm/IR/Function.h"
#include "llvm/IR/Module.h"
#include "llvm/IR/Constants.h"
#include "llvm/IR/DerivedTypes.h"
#include "llvm/Support/Debug.h"
#include "llvm/Support/raw_ostream.h"

#include "llvm/IR/LegacyPassManager.h"
#include "llvm/PassRegistry.h"
#include "llvm/Transforms/IPO/PassManagerBuilder.h"

#include <list>

namespace oh {

ReachableFunctions::ReachableFunctions(llvm::Module* M,
                                       llvm::CallGraph* cfg)
    : m_module(M)
    , m_callGraph(cfg)
{
}


ReachableFunctions::FunctionSet
ReachableFunctions::getReachableFunctions(llvm::Function* F)
{
    FunctionSet reachable_functions;

    const auto& functionTypes = collect_function_types();

    llvm::CallGraphNode* entryNode = (*m_callGraph)[F];
    collect_reachable_functions(entryNode,
                                reachable_functions);

    collect_indirectly_reachable_functions(reachable_functions, functionTypes);
    return reachable_functions;
}

ReachableFunctions::FunctionTypeMap
ReachableFunctions::collect_function_types()
{
    FunctionTypeMap functionTypes;
    for (auto& F : *m_module) {
        functionTypes[F.getFunctionType()].insert(&F);
    }
    return functionTypes;
}

void ReachableFunctions::collect_reachable_functions(
                                llvm::CallGraphNode* callNode,
                                FunctionSet& reachable_functions)
{
    if (!callNode) {
        return;
    }
    llvm::Function* nodeF = callNode->getFunction();
    if (!nodeF || nodeF->isDeclaration()) {
        return;
    }
    if (!reachable_functions.insert(nodeF).second) {
        return;
    }
    for (auto call_it = callNode->begin(); call_it != callNode->end(); ++call_it) {
        collect_reachable_functions(call_it->second, reachable_functions);
    }
}

void ReachableFunctions::collect_indirectly_reachable_functions(
                                                FunctionSet& reachable_functions,
                                                const FunctionTypeMap& functionTypes)
{
    std::list<llvm::Function*> working_list;
    working_list.insert(working_list.end(), reachable_functions.begin(), reachable_functions.end());
    FunctionSet processed_functions;

    while (!working_list.empty()) {
        auto F = working_list.front();
        working_list.pop_front();
        if (!processed_functions.insert(F).second) {
            continue;
        }
        const auto& indirectly_called = collect_indirectly_called_functions(F, functionTypes);
        for (auto& indirectF : indirectly_called) {
            if (!reachable_functions.insert(indirectF).second) {
                continue;
            }
            working_list.push_back(indirectF);
            FunctionSet reachables;
            collect_reachable_functions((*m_callGraph)[indirectF], reachables);
            for (auto& F : reachables) {
                if (reachable_functions.insert(F).second) {
                    working_list.push_back(F);
                }
            }
        }
    }
}

ReachableFunctions::FunctionSet
ReachableFunctions::collect_indirectly_called_functions(llvm::Function* F,
                                                        const FunctionTypeMap& functionTypes)
{
    FunctionSet called_functions;
    for (auto& B : *F) {
        for (auto& I : B) {
            llvm::FunctionType* calledType = nullptr;
            if (auto* callInst = llvm::dyn_cast<llvm::CallInst>(&I)) {
                if (!callInst->getCalledFunction()) {
                    calledType = callInst->getFunctionType();
                }
            } else if (auto* invokeInst = llvm::dyn_cast<llvm::InvokeInst>(&I)) {
                if (!invokeInst->getCalledFunction()) {
                    calledType = callInst->getFunctionType();
                }
            }
            if (calledType) {
                auto pos = functionTypes.find(calledType);
                if (pos != functionTypes.end()) {
                    called_functions.insert(pos->second.begin(), pos->second.end());
                }
            }
        }
    }
    return called_functions;
}

 
char ReachableFunctionsPass::ID = 0;

bool ReachableFunctionsPass::runOnModule(llvm::Module &M)
{
    llvm::CallGraph* CG = &getAnalysis<llvm::CallGraphWrapperPass>().getCallGraph();
    ReachableFunctions reachableFs(&M, CG);
    llvm::Function* mainF = M.getFunction("main");
    if (!mainF) {
        llvm::dbgs() << "No function main\n";
        return false;
    }
    const auto& reachable_from_main = reachableFs.getReachableFunctions(mainF);
    llvm::dbgs() << "Function reachable from main are\n";
    for (const auto& F : reachable_from_main) {
        llvm::dbgs() << "+++" << F->getName() << "\n";
    }

    llvm::dbgs() << "Non reachable functions\n";
    for (auto& F : M) {
        if (F.isDeclaration()) {
            continue;
        }
        if (reachable_from_main.find(&F) == reachable_from_main.end()) {
            llvm::dbgs() << "---" << F.getName() << "\n";
        }
    }
    return false;
}

void ReachableFunctionsPass::getAnalysisUsage(llvm::AnalysisUsage &AU) const
{
    AU.addRequired<llvm::CallGraphWrapperPass>();
    AU.setPreservesAll();
}

static llvm::RegisterPass<ReachableFunctionsPass> X("reachables","Find main reachable functions");


}

