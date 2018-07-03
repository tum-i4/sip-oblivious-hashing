#include "FunctionOHPaths.h"

#include "llvm/IR/BasicBlock.h"
#include "llvm/IR/Function.h"
#include "llvm/IR/Module.h"
#include "llvm/Support/Debug.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/IR/Dominators.h"
#include "llvm/Analysis/LoopInfo.h"

#include "llvm/Analysis/CFGPrinter.h"
#include "llvm/Analysis/CFG.h"
#include "llvm/Support/FileSystem.h"

#include "llvm/IR/LegacyPassManager.h"
#include "llvm/Transforms/IPO/PassManagerBuilder.h"

#include <algorithm>
#include <unordered_map>

namespace wrappers {

class OHPathsFunction
{
public:
    OHPathsFunction(llvm::Function* F, const oh::FunctionOHPaths& paths)
        : m_F(F)
    {
        setup_block_paths(paths);
    }

    llvm::Function* get_function()
    {
        return m_F;
    }

    const llvm::Function* get_function() const
    {
        return m_F;
    }

    const std::unordered_map<llvm::BasicBlock*, std::vector<int>>& get_blocks() const
    {
        return m_blocks;
    }

    std::unordered_map<llvm::BasicBlock*, std::vector<int>>& get_blocks()
    {
        return m_blocks;
    }

private:
    void setup_block_paths(const oh::FunctionOHPaths& paths);

private:
    llvm::Function* m_F;
    std::unordered_map<llvm::BasicBlock*, std::vector<int>> m_blocks;
};

void OHPathsFunction::setup_block_paths(const oh::FunctionOHPaths& paths)
{
    unsigned i = 0;
    for (const auto& path : paths) {
        for (const auto& B : path) {
            m_blocks[B].push_back(i);
        }
        ++i;
    }
}

} // namespace wrappers

namespace llvm {

template <>
struct GraphTraits<wrappers::OHPathsFunction*> : public GraphTraits<BasicBlock*>
{
    static NodeRef getEntryNode(wrappers::OHPathsFunction* OHF) {return &OHF->get_function()->getEntryBlock();}
    using nodes_iterator = pointer_iterator<Function::iterator>;
    static nodes_iterator nodes_begin(wrappers::OHPathsFunction* OHF) {
        return nodes_iterator(OHF->get_function()->begin());
    }
    static nodes_iterator nodes_end(wrappers::OHPathsFunction* OHF) {
        return nodes_iterator(OHF->get_function()->end());
    }
    static size_t size(wrappers::OHPathsFunction* OHF) {return OHF->get_function()->size();}
};

template<>
struct GraphTraits<const wrappers::OHPathsFunction*> : public GraphTraits<const BasicBlock*>
{
    static NodeRef getEntryNode(const wrappers::OHPathsFunction* OHF) {return &OHF->get_function()->getEntryBlock();}
    using nodes_iterator = pointer_iterator<Function::const_iterator>;
    static nodes_iterator nodes_begin(const wrappers::OHPathsFunction* OHF) {
        return nodes_iterator(OHF->get_function()->begin());
    }
    static nodes_iterator nodes_end(const wrappers::OHPathsFunction* OHF) {
        return nodes_iterator(OHF->get_function()->end());
    }
    static size_t size(const wrappers::OHPathsFunction* OHF) {return OHF->get_function()->size();}
};

template<>
class DOTGraphTraits<const wrappers::OHPathsFunction*> : public DefaultDOTGraphTraits
{
public:
    DOTGraphTraits (bool isSimple=false)
        : DefaultDOTGraphTraits(isSimple)
    {
    }

    static std::string getGraphName(const wrappers::OHPathsFunction* F) {
        return "CFG for '" + F->get_function()->getName().str() + "' function";
    }

    static std::string getSimpleNodeLabel(const BasicBlock *Node,
                                          const wrappers::OHPathsFunction* OHF)
    {
        if (!Node->getName().empty()) {
            return Node->getName().str();
        }

        std::string Str;
        raw_string_ostream OS(Str);
        Node->printAsOperand(OS, false);
        return OS.str();
    }

    static std::string getCompleteNodeLabel(const BasicBlock *Node,
                                            const wrappers::OHPathsFunction* OHF)
    {
        std::string Str;
        raw_string_ostream OS(Str);
        OS << Node->getName() << "\n";
        auto pos = OHF->get_blocks().find(const_cast<BasicBlock*>(Node));
        if (pos == OHF->get_blocks().end()) {
            return OS.str();
        }
        for (const auto& index : pos->second) {
            OS << index;
            if (index != pos->second.back()) {
                OS << ",  ";
            }
        }
        if (pos->second.size() == 1) {
            OS << "\nend path\n";
        }
        OS << "\n";
        return OS.str();
    }

    static std::string getEdgeSourceLabel(const BasicBlock *Node,
                                          succ_const_iterator I)
    {
        // Label source of conditional branches with "T" or "F"
        if (const BranchInst *BI = dyn_cast<BranchInst>(Node->getTerminator()))
            if (BI->isConditional())
                return (I == succ_begin(Node)) ? "T" : "F";

        // Label source of switch edges with the associated value.
        if (const SwitchInst *SI = dyn_cast<SwitchInst>(Node->getTerminator())) {
            unsigned SuccNo = I.getSuccessorIndex();

            if (SuccNo == 0) return "def";

            std::string Str;
            raw_string_ostream OS(Str);
            SwitchInst::ConstCaseIt Case =
                SwitchInst::ConstCaseIt::fromSuccessorIndex(SI, SuccNo);
            OS << (*Case).getCaseValue()->getValue();
            return OS.str();
        }
        return "";
    }

    std::string getNodeLabel(const BasicBlock* Node,
                             const wrappers::OHPathsFunction* Graph)
    {
        if (isSimple()) {
            return getSimpleNodeLabel(Node, Graph);
        } else {
            return getCompleteNodeLabel(Node, Graph);
        }
    }
};

} // namespace llvm


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

bool FunctionOHPaths::pathContainsBlock(const OHPath& path, llvm::BasicBlock* block)
{
    return std::find(path.begin(), path.end(), block) != path.end();
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

    wrappers::OHPathsFunction OHF(&F, paths);
    const wrappers::OHPathsFunction* Graph = &OHF;
    std::string Filename = "cfg." + F.getName().str() + ".dot";
    std::error_code EC;
    llvm::raw_fd_ostream File(Filename, EC, llvm::sys::fs::F_Text);
    std::string GraphName = llvm::DOTGraphTraits<const wrappers::OHPathsFunction*>::getGraphName(Graph);
    std::string Title = GraphName + " for '" + F.getName().str() + "' function";

    llvm::dbgs() << "Writing OH short range CFG for " << F.getName() << "\n";
    if (!EC) {
        llvm::WriteGraph(File, Graph, false, Title);
    } else {
        llvm::dbgs() << "  error opening file for writing!";
    }
    //paths.dump();

    return false;
}

static llvm::RegisterPass<FunctionOHPathsPass> X("oh-paths", "Finds paths for short-range oh");


} // namespace oh

