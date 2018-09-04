#pragma once

#include "llvm/Pass.h"
//#include "llvm/IR/Dominators.h"

#include <vector>

namespace llvm {
class BasicBlock;
class Function;
class DominatorTree;
class LoopInfo; 
template <typename T> class DomTreeNodeBase;
}

namespace oh {

class FunctionOHPaths
{
public:
    using OHPath = std::vector<llvm::BasicBlock*>;
    using OHPaths = std::vector<OHPath>;
    using iterator = OHPaths::iterator;
    using const_iterator = OHPaths::const_iterator;

public:
    FunctionOHPaths(llvm::Function* F,
                    llvm::DominatorTree* domTree,
                    llvm::LoopInfo* loopInfo);

    FunctionOHPaths(const FunctionOHPaths&) = delete;
    FunctionOHPaths(FunctionOHPaths&&) = delete;
    FunctionOHPaths& operator =(const FunctionOHPaths&) = delete;
    FunctionOHPaths& operator =(FunctionOHPaths&&) = delete;

public:
    void constructOHPaths();

    const OHPaths& getOHPaths() const
    {
        return m_paths;
    }

    iterator begin()
    {
        return m_paths.begin();
    }

    iterator end()
    {
        return m_paths.end();
    }

    const_iterator begin() const
    {
        return m_paths.begin();
    }

    const_iterator end() const
    {
        return m_paths.end();
    }

    unsigned size() const
    {
        return m_paths.size();
    }

    const OHPath& operator [](unsigned i) const
    {
        assert(i < size());
        return m_paths[i];
    }

    OHPath& operator [](unsigned i)
    {
        assert(i < size());
        return m_paths[i];
    }

    // debug function
    void dump() const;

    static bool pathContainsBlock(const OHPath& path, llvm::BasicBlock* block);

private:
    using DomTreeNode = llvm::DomTreeNodeBase<llvm::BasicBlock>;
    void dfsConstruct(DomTreeNode* node, OHPath path);
    void splitLoopPaths();
    OHPaths splitLoopPath(const OHPath& path);

private:
    llvm::Function* m_F;
    llvm::DominatorTree* m_domTree;
    llvm::LoopInfo* m_loopInfo;
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

