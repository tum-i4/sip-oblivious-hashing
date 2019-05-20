#include "Slicer.h"

// llvm includes
#include "llvm/IR/Constants.h"
#include "llvm/IR/Function.h"
#include "llvm/IR/InstrTypes.h"
#include "llvm/IR/Instructions.h"
#include "llvm/Support/Casting.h"
#include "llvm/Support/Debug.h"
#include "llvm/Support/raw_ostream.h"

// dg includes
#include "dg/analysis/PointsTo/Pointer.h"
#include "dg/llvm/LLVMDependenceGraphBuilder.h"
#include "dg/llvm/LLVMDependenceGraph.h"

#include <map>

namespace oh {

Slicer::Slicer(llvm::Module* M)
    : m_slice_id(0)
    , m_module(M)
    , m_dg(new dg::LLVMDependenceGraph())
{
    dg::llvmdg::LLVMDependenceGraphOptions options;
    options.PTAOptions.analysisType = dg::LLVMPointerAnalysisOptions::AnalysisType::fi;
    options.RDAOptions.analysisType = dg::analysis::LLVMReachingDefinitionsAnalysisOptions::AnalysisType::dense;

    dg::llvmdg::LLVMDependenceGraphBuilder builder(M, options);
    m_dg = std::move(builder.constructCFGOnly());
    m_dg = builder.computeDependencies(std::move(m_dg));

    //buildDG();
    //computeEdges();
}

dg::LLVMDependenceGraph* Slicer::getDG(llvm::Function* F)
{
   auto CFs = dg::getConstructedFunctions();
   return CFs[F];
}

bool Slicer::slice(llvm::Function* F, const std::string& criteria)
{
    m_slice.clear();
    std::set<dg::LLVMNode *> callsites;

    bool ret = m_dg->getCallSites(criteria.c_str(), &callsites);
    if (!ret) {
        llvm::errs() << "Did not find slicing criterion: "
                     << criteria << "\n";
        return false;
    }

    // make sure for each slice call m_slice_id is unique
    ++m_slice_id;

    for (dg::LLVMNode *start : callsites) {
        m_slice_id = m_slicer.mark(start, m_slice_id);
    }

    computeSlice(F);

    return true;
}

//void Slicer::computeEdges()
//{
//    m_RD->run<dg::analysis::rd::ReachingDefinitionsAnalysis>();
//
//    dg::LLVMDefUseAnalysis DUA(m_dg.get(), m_RD.get(),
//                               m_PTA.get(), false);
//    DUA.run(); // add def-use edges according that
//    m_dg->computeControlDependencies(dg::CD_ALG::CLASSIC);
//}

//void Slicer::buildDG()
//{
//    m_PTA->run<dg::analysis::pta::PointerAnalysisFI>();
//    m_dg->build(m_module, m_PTA.get());
//}

void Slicer::computeSlice(llvm::Function* F)
{
    const auto& CFs = dg::getConstructedFunctions();
    for (auto& cf : CFs) {
        if (cf.first->getName() != F->getName()) {
            continue;
        }
        computeFunctionSlice(llvm::dyn_cast<llvm::Function>(cf.first), cf.second);
    }
}

void Slicer::computeFunctionSlice(llvm::Function* F, dg::LLVMDependenceGraph* F_dg)
{
    for (auto& B : *F) {
        for (auto& I : B) {
            auto node = F_dg->find(&I);
            if (node == F_dg->end() || node->second->getSlice() != m_slice_id) {
                continue;
            }
            m_slice.push_back(&I);
        }
    }
}

} // namespace oh
