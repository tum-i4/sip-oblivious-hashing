#pragma once

#include "llvm/IR/Module.h"
#include "llvm-dg/Slicer.h"
#include "llvm-dg/LLVMDependenceGraph.h"
#include "llvm-dg/llvm/analysis/PointsTo/PointsTo.h"
#include "llvm-dg/llvm/analysis/ReachingDefinitions/ReachingDefinitions.h"

#include <memory>
#include <vector>

namespace llvm {
class Module;
class Instruction;
class Function;
}

namespace oh {

class Slicer
{
public:
    using Slice = std::vector<llvm::Instruction*>;
public:
    Slicer(llvm::Function* F, const std::string& criteria);

    const dg::LLVMDependenceGraph& getDG() const
    {
        return m_dg;
    }

    dg::LLVMDependenceGraph& getDG()
    {
        return m_dg;
    }

    bool slice();

private:
    void computeEdges();
    void buildDG();
    void computeSlice();
    void computeFunctionSlice(llvm::Function* F, dg::LLVMDependenceGraph* F_dg);

private:
    std::string m_criteria;
    unsigned m_slice_id;
    llvm::Module *m_module;
    llvm::Function *m_F;
    std::unique_ptr<dg::LLVMPointerAnalysis> m_PTA;
    std::unique_ptr<dg::analysis::rd::LLVMReachingDefinitions> m_RD;
    dg::LLVMDependenceGraph m_dg;
    dg::LLVMSlicer m_slicer;
    Slice m_slice;
}; // class Slicer

}


