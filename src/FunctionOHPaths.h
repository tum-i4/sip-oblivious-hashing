#pragma once

#include "llvm/Pass.h"
#include "llvm/IR/Dominators.h"

#include <vector>

namespace llvm {
class BasicBlock;
class Function;
}

namespace oh {

class FunctionOHPaths
{
public:
    using OHPath = std::vector<llvm::BasicBlock*>;
    using OHPaths = std::vector<OHPath>;

public:
    FunctionOHPaths(llvm::Function* F, llvm::DominatorTree* domTree);

    FunctionOHPaths(const FunctionOHPaths&) = delete;
    FunctionOHPaths& operator =(const FunctionOHPaths&) = delete;

public:
    void constructOHPaths();

    const OHPaths& getOHPaths() const
    {
        return m_paths;
    }
    
    // debug function
    void dump() const;

private:
    using DomTreeNode = llvm::DomTreeNodeBase<llvm::BasicBlock>;
    void dfsConstruct(DomTreeNode* node, OHPath path);

private:
    llvm::Function* m_F;
    llvm::DominatorTree* m_domTree;
    OHPaths m_paths;
}; // class FunctionOHPaths


class FunctionOHPathsPass : public llvm::FunctionPass
{
public:
    static char ID;

    FunctionOHPathsPass()
        : llvm::FunctionPass(ID)
    {
    }

    bool runOnFunction(llvm::Function &F) override;
    void getAnalysisUsage(llvm::AnalysisUsage &AU) const override;
};

} // namespace oh

