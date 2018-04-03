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
#include "llvm-dg/Slicer.h"
#include "llvm-dg/LLVMDG2Dot.h"
#include "llvm-dg/llvm/analysis/DefUse.h"
#include "llvm-dg/analysis/PointsTo/PointsToFlowInsensitive.h"
#include "llvm-dg/analysis/PointsTo/PointsToFlowSensitive.h"
#include "llvm-dg/analysis/PointsTo/PointsToWithInvalidate.h"
#include "llvm-dg/analysis/PointsTo/Pointer.h"

#include <map>

namespace oh {

Slicer::Slicer(llvm::Function* F, const std::string& criteria)
    : m_criteria(criteria)
    , m_slice_id(0)
    , m_module(F->getParent())
    , m_F(F)
    , m_PTA(new LLVMPointerAnalysis(m_module))
    , m_RD(new dg::analysis::rd::LLVMReachingDefinitions(m_module, m_PTA.get()))
{
}

bool Slicer::slice()
{
    std::set<dg::LLVMNode *> callsites;

    bool ret = m_dg.getCallSites(m_criteria.c_str(), &callsites);
    if (!ret) {
        llvm::errs() << "Did not find slicing criterion: "
                     << m_criteria << "\n";
        return false;
    }

    // if we found slicing criterion, compute the rest
    // of the graph. Otherwise just slice away the whole graph
    // Also compute the edges when the user wants to annotate
    // the file - due to debugging.
    computeEdges();

    m_slice_id = 0xdead;

    for (LLVMNode *start : callsites) {
        m_slice_id = m_slicer.mark(start, m_slice_id);
    }

    computeSlice();

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
    m_dg.build(&*m_module, m_PTA.get());
}

void Slicer::computeSlice()
{
    const auto& CF = getConstructedFunctions();
    for (auto& F : CF) {
        if (F.first->getName() != m_F->getName()) {
            continue;
        }
        computeFunctionSlice(llvm::dyn_cast<llvm::Function>(F.first), F.second);
    }
}

void Slicer::computeFunctionSlice(llvm::Function* F, dg::LLVMDependenceGraph* F_dg)
{
    for (auto I = F_dg->begin(), E = F_dg->end(); I != E; ++I) {
        if (I->second->getSlice() == 0) {
            continue;
        }
        if (auto* blk = llvm::dyn_cast<llvm::BasicBlock>(I->second->getValue())) {
            llvm::dbgs() << "Slice Block: " << blk->getName() << "\n";
        } else if (auto* instr = llvm::dyn_cast<llvm::Instruction>(I->second->getValue())) {
            llvm::dbgs() << "Slice Instruction: " << instr->getName() << "\n";
        }
    }

}

} // namespace oh
