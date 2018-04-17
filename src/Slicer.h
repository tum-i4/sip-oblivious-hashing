#pragma once

#include "llvm/IR/Module.h"
#include "llvm-dg/llvm/LLVMDependenceGraph.h"
#include "llvm-dg/llvm/Slicer.h"
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
    Slicer(llvm::Module* M);

    const dg::LLVMDependenceGraph& getDG() const
    {
        return *m_dg;
    }

    dg::LLVMDependenceGraph& getDG()
    {
        return *m_dg;
    }

    dg::LLVMDependenceGraph* getDG(llvm::Function* F);

    const Slice& getSlice() const
    {
        return m_slice;
    }

    const unsigned getSliceId() const
    {
        return m_slice_id;
    }

    bool slice(llvm::Function* F, const std::string& criteria);

private:
    void computeEdges();
    void buildDG();
    void computeSlice(llvm::Function* F);
    void computeFunctionSlice(llvm::Function* F, dg::LLVMDependenceGraph* F_dg);

private:
    unsigned m_slice_id;
    llvm::Module *m_module;
    std::unique_ptr<dg::LLVMPointerAnalysis> m_PTA;
    std::unique_ptr<dg::analysis::rd::LLVMReachingDefinitions> m_RD;
    std::unique_ptr<dg::LLVMDependenceGraph> m_dg;
    dg::LLVMSlicer m_slicer;
    Slice m_slice;
}; // class Slicer

}


