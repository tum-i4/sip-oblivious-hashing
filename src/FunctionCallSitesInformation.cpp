#include "FunctionCallSitesInformation.h"

#include "input-dependency/FunctionInputDependencyResultInterface.h"
#include "input-dependency/IndirectCallSitesAnalysis.h"

#include "llvm/ADT/SCCIterator.h"
#include "llvm/Analysis/CallGraph.h"
#include "llvm/Analysis/CallGraphSCCPass.h"
#include "llvm/Analysis/LoopInfo.h"
#include "llvm/IR/BasicBlock.h"
#include "llvm/IR/Constants.h"
#include "llvm/IR/Function.h"
#include "llvm/IR/InstrTypes.h"
#include "llvm/IR/Instructions.h"
#include "llvm/IR/Module.h"
#include "llvm/Support/Casting.h"
#include "llvm/Support/Debug.h"
#include "llvm/Support/raw_ostream.h"

#include "llvm/IR/LegacyPassManager.h"
#include "llvm/Transforms/IPO/PassManagerBuilder.h"

#include <vector>

namespace oh {

void FunctionCallSiteData::setCallGraph(llvm::CallGraph* callGraph)
{
    m_callGraph = callGraph;
}

void FunctionCallSiteData::setLoopInfoGetter(const LoopInfoGetter& loopInfoGetter)
{
    m_loopInfoGetter = loopInfoGetter;
}

void FunctionCallSiteData::setInputDepInfo(const InputDependencyAnalysisType& inputDep)
{
    m_inputDepRes = inputDep;
}

void FunctionCallSiteData::setIndirectCallSiteInfo(const input_dependency::IndirectCallSitesAnalysisResult* indirectCalls)
{
    m_indirectCalls = indirectCalls;
}

void FunctionCallSiteData::setVirtualCallSiteInfo(const VirtualCallSiteAnalysisResult* virtualCalls)
{
    m_virtualCalls = virtualCalls;
}

bool FunctionCallSiteData::isFunctionCalledInLoop(llvm::Function* F) const
{
    return m_functionsCalledInLoop.find(F) != m_functionsCalledInLoop.end();
}

unsigned FunctionCallSiteData::getNumberOfFunctionCallSites(llvm::Function* F) const
{
    auto pos = m_functionCallSiteNumbers.find(F);
    if (pos == m_functionCallSiteNumbers.end()) {
        return 0;
    }
    return pos->second;
}

std::vector<llvm::Function*> FunctionCallSiteData::get_functions_in_top_down_order(const llvm::Module& M)
{
    std::vector<llvm::Function*> function_top_down;
    function_top_down.reserve(M.getFunctionList().size());

    typedef llvm::scc_iterator<llvm::CallGraph*> callGraph_scc_iterator;;
    auto CGI = callGraph_scc_iterator::begin(m_callGraph);
    llvm::CallGraphSCC CurSCC(*m_callGraph, &CGI);
    while (!CGI.isAtEnd()) {
        const std::vector<llvm::CallGraphNode *> &NodeVec = *CGI;
        CurSCC.initialize(NodeVec);
        for (llvm::CallGraphNode* node : CurSCC) {
            llvm::Function* F = node->getFunction();
            if (F == nullptr || F->isDeclaration()) {
                continue;
            }
            function_top_down.insert(function_top_down.begin(), F);
        }
        ++CGI;
    }
    return function_top_down;
}

void FunctionCallSiteData::process_function(llvm::Function* F)
{
    auto F_input_dependency_info = m_inputDepRes->getAnalysisInfo(F);
    if (!F_input_dependency_info || F_input_dependency_info->isInputDepFunction()) {
        m_functionsCalledInLoop.erase(F);
        m_functionCallSiteNumbers.erase(F);
        return;
    }
    bool called_in_loop = m_functionsCalledInLoop.find(F) != m_functionsCalledInLoop.end();
    unsigned call_count = m_functionCallSiteNumbers[F];
    llvm::LoopInfo* LI = m_loopInfoGetter(*F);
    for (auto& B : *F) {
        if (F_input_dependency_info->isInputDependentBlock(&B)) {
            continue;
        }
        for (auto& I : B) {
            std::vector<llvm::Function*> called_functions;
            if (auto* call = llvm::dyn_cast<llvm::CallInst>(&I)) {
                called_functions = get_call_targets(call);
            } else if (auto* invoke = llvm::dyn_cast<llvm::InvokeInst>(&I)) {
                called_functions = get_call_targets(invoke);
            }
            for (auto& called_F : called_functions) {
                if (called_F->isDeclaration()) {
                    continue;
                }
                if (called_in_loop || LI->getLoopFor(&B) != nullptr) {
                    m_functionsCalledInLoop.insert(called_F);
                    // if function is called in a loop remove from call site numbers map
                    m_functionCallSiteNumbers.erase(called_F);
                } else {
                    if (call_count == 0) {
                        ++m_functionCallSiteNumbers[called_F];
                    } else {
                        m_functionCallSiteNumbers[called_F] += call_count;
                    }
                }
            }
        }
    }
}

template <class T>
std::vector<llvm::Function*> FunctionCallSiteData::get_call_targets(T* instruction)
{
    std::vector<llvm::Function*> call_targets;
    llvm::Function* called_F = instruction->getCalledFunction();
    if (called_F) {
        call_targets.push_back(called_F);
    } else if (m_indirectCalls->hasIndirectTargets(instruction)) {
        const input_dependency::FunctionSet& targets = m_indirectCalls->getIndirectTargets(instruction);
        call_targets.insert(call_targets.end(), targets.begin(), targets.end());
    } else if (m_virtualCalls->hasVirtualCallCandidates(instruction)) {
        const input_dependency::FunctionSet& targets = m_virtualCalls->getVirtualCallCandidates(instruction);
        call_targets.insert(call_targets.end(), targets.begin(), targets.end());
    }
    return call_targets;
}

void FunctionCallSiteData::dump()
{
    llvm::dbgs() << "Functions called in loop\n";
    for (const auto& F : m_functionsCalledInLoop) {
        llvm::dbgs() << F->getName() << "\n";
    }

    llvm::dbgs() << "Function call numbers\n";
    for (const auto& f_entry : m_functionCallSiteNumbers) {
        llvm::dbgs() << f_entry.first->getName() << " -- " << f_entry.second << "\n";
    }
}

void FunctionCallSiteData::gatherCallSiteData(llvm::Module& M)
{
    std::vector<llvm::Function*> function_top_down = get_functions_in_top_down_order(M);
    for (auto& F : function_top_down) {
        // assume that input deps will be handled by any pass using information of this pass.
        process_function(F);
    }
    dump();
}

bool FunctionCallSiteInformationPass::runOnModule(llvm::Module &M)
{
    const auto &input_dependency_info = getAnalysis<input_dependency::InputDependencyAnalysisPass>().getInputDependencyAnalysis();
    const auto& indirectCallAnalysis = getAnalysis<input_dependency::IndirectCallSitesAnalysis>().getIndirectsAnalysisResult();
    const auto& virtualCallAnalysis = getAnalysis<input_dependency::IndirectCallSitesAnalysis>().getVirtualsAnalysisResult();
    llvm::CallGraph* callGraph = &getAnalysis<llvm::CallGraphWrapperPass>().getCallGraph();
    const auto& loopInfoGetter = [this] (llvm::Function& F) {return &getAnalysis<llvm::LoopInfoWrapperPass>(F).getLoopInfo();};

    m_callSiteData.setCallGraph(callGraph);
    m_callSiteData.setLoopInfoGetter(loopInfoGetter);
    m_callSiteData.setInputDepInfo(input_dependency_info);
    m_callSiteData.setIndirectCallSiteInfo(&indirectCallAnalysis);
    m_callSiteData.setVirtualCallSiteInfo(&virtualCallAnalysis);

    m_callSiteData.gatherCallSiteData(M);

    return false;
}

const FunctionCallSiteData& FunctionCallSiteInformationPass::getAnalysisResult() const
{
    return m_callSiteData;
}

void FunctionCallSiteInformationPass::getAnalysisUsage(llvm::AnalysisUsage &AU) const
{
    AU.setPreservesCFG();
    AU.addRequired<llvm::CallGraphWrapperPass>();
    AU.addPreserved<llvm::CallGraphWrapperPass>();
    AU.addRequired<llvm::LoopInfoWrapperPass>();
    AU.addRequired<input_dependency::IndirectCallSitesAnalysis>();
    AU.addRequired<input_dependency::InputDependencyAnalysisPass>();
    AU.setPreservesAll();
}

char FunctionCallSiteInformationPass::ID = 0;
static llvm::RegisterPass<FunctionCallSiteInformationPass> X("callsite-info","Call site information");

}

