#include "FunctionOHPaths.h"

#include "llvm/IR/BasicBlock.h"
#include "llvm/IR/Function.h"
#include "llvm/IR/Module.h"
#include "llvm/Support/Debug.h"
#include "llvm/Support/raw_ostream.h"

#include "llvm/IR/LegacyPassManager.h"
#include "llvm/Transforms/IPO/PassManagerBuilder.h"

namespace oh {

FunctionOHPaths::FunctionOHPaths(llvm::Function* F, llvm::DominatorTree* domTree)
    : m_F(F)
    , m_domTree(domTree)
{
}

void FunctionOHPaths::constructOHPaths()
{
    auto* rootNode = m_domTree->getRootNode();
    OHPath path;
    dfsConstruct(rootNode, path);
}

void FunctionOHPaths::dump() const
{
    if (m_paths.empty()) {
        llvm::dbgs() << "No path generated\n";
        return;
    }
    llvm::dbgs() << "*** OH Paths of functio " << m_F->getName() << " ****\n";
    for (const auto& path : m_paths) {
        for (const auto& block : path) {
            llvm::dbgs() << block->getName() << "  ";
        }
        llvm::dbgs() << "\n";
    }
}

void FunctionOHPaths::dfsConstruct(DomTreeNode* node, OHPath path)
{
    if (node == nullptr) {
        m_paths.push_back(path);
        return;
    }
    path.push_back(node->getBlock());
    if (node->getNumChildren() == 0) {
        m_paths.push_back(path);
        return;
    }
    auto it = node->begin();
    while (it != node->end()) {
        dfsConstruct(*it, path);
        ++it;
    }
}

char FunctionOHPathsPass::ID = 0;

void FunctionOHPathsPass::getAnalysisUsage(llvm::AnalysisUsage &AU) const {
    AU.setPreservesAll();
    AU.addRequired<llvm::DominatorTreeWrapperPass>();
}

bool FunctionOHPathsPass::runOnFunction(llvm::Function& F)
{
    llvm::DominatorTree& domTree = getAnalysis<llvm::DominatorTreeWrapperPass>().getDomTree();
    FunctionOHPaths paths(&F, &domTree);
    paths.constructOHPaths();
    paths.dump();

    return false;
}

static llvm::RegisterPass<FunctionOHPathsPass> X("oh-paths", "Finds paths for short-range oh");


} // namespace oh

