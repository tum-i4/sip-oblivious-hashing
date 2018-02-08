#pragma once

#include "llvm/Pass.h"

#include "input-dependency/InputDependencyAnalysisPass.h"

#include <unordered_map>
#include <unordered_set>
#include <vector>
#include <functional>

namespace llvm {
class Function;
class LoopInfo;
class CallGraph;
}

namespace input_dependency {
class IndirectCallSitesAnalysisResult;
class VirtualCallSiteAnalysisResult;
}

namespace oh {

/// Collects call site data for input independent functions.
class FunctionCallSiteData
{
private:
    using InputDependencyAnalysisType = input_dependency::InputDependencyAnalysisPass::InputDependencyAnalysisType;
    using IndirectCallSitesAnalysisResult = input_dependency::IndirectCallSitesAnalysisResult;
    using VirtualCallSiteAnalysisResult = input_dependency::VirtualCallSiteAnalysisResult;

public:
    using LoopInfoGetter = std::function<llvm::LoopInfo* (llvm::Function& )>;

public:
    FunctionCallSiteData() = default;

    void setCallGraph(llvm::CallGraph* callGraph);
    void setLoopInfoGetter(const LoopInfoGetter& loopInfoGetter);
    void setInputDepInfo(const InputDependencyAnalysisType& inputDep);
    void setIndirectCallSiteInfo(const IndirectCallSitesAnalysisResult* indirectCalls);
    void setVirtualCallSiteInfo(const VirtualCallSiteAnalysisResult* virtualCalls);

    bool isFunctionCalledInLoop(llvm::Function* F) const;
    unsigned getNumberOfFunctionCallSites(llvm::Function* F) const;

    void gatherCallSiteData(llvm::Module& M);

private:
    std::vector<llvm::Function*> get_functions_in_top_down_order(const llvm::Module& M);
    void process_function(llvm::Function* F);
    template <class T>
    std::vector<llvm::Function*> get_call_targets(T* instruction);

    void dump();

private:
    llvm::CallGraph* m_callGraph;
    LoopInfoGetter m_loopInfoGetter;
    InputDependencyAnalysisType m_inputDepRes;
    const input_dependency::IndirectCallSitesAnalysisResult* m_indirectCalls;
    const input_dependency::VirtualCallSiteAnalysisResult* m_virtualCalls;

    std::unordered_set<llvm::Function*> m_functionsCalledInLoop;
    std::unordered_map<llvm::Function*, unsigned> m_functionCallSiteNumbers;
};

class FunctionCallSiteInformationPass : public llvm::ModulePass
{
public:
    static char ID;

    FunctionCallSiteInformationPass()
        : llvm::ModulePass(ID)
    {
    }

public:
    bool runOnModule(llvm::Module &M) override;
    void getAnalysisUsage(llvm::AnalysisUsage &AU) const override;

    const FunctionCallSiteData& getAnalysisResult() const;

private:
    FunctionCallSiteData m_callSiteData;
};

}

