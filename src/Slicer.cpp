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
#include "llvm-dg/llvm/analysis/DefUse.h"
#include "llvm-dg/analysis/PointsTo/PointsToFlowInsensitive.h"
#include "llvm-dg/analysis/PointsTo/PointsToFlowSensitive.h"
#include "llvm-dg/analysis/PointsTo/PointsToWithInvalidate.h"
#include "llvm-dg/analysis/PointsTo/Pointer.h"
#include "llvm-dg/llvm/analysis/PointsTo/PointsTo.h"

#include <map>

namespace oh {

Slicer::Slicer(llvm::Module* M)
    : m_slice_id(0)
    , m_module(M)
    , m_PTA(new dg::LLVMPointerAnalysis(m_module))
    , m_RD(new dg::analysis::rd::LLVMReachingDefinitions(m_module, m_PTA.get()))
{
    buildDG();
    computeEdges();
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

    bool ret = m_dg.getCallSites(criteria.c_str(), &callsites);
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

void Slicer::computeEdges()
{
    m_RD->run();

    dg::LLVMDefUseAnalysis DUA(&m_dg, m_RD.get(),
                               m_PTA.get());
    DUA.run(); // add def-use edges according that
    m_dg.computeControlDependencies(dg::CD_ALG::CLASSIC);
}

void Slicer::buildDG()
{
    m_PTA->run<dg::analysis::pta::PointsToFlowInsensitive>();
    m_dg.build(m_module, m_PTA.get());
}

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
