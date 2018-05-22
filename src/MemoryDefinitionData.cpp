#include "MemoryDefinitionData.h"

#include "llvm/Transforms/Utils/MemorySSA.h"
#include "llvm/IR/BasicBlock.h"
#include "llvm/Support/Casting.h"
#include "llvm/IR/Instructions.h"

#include "llvm/Pass.h"
#include "llvm/Transforms/IPO/PassManagerBuilder.h"
#include "llvm/IR/LegacyPassManager.h"

namespace oh {

namespace {

void add_defData(llvm::BasicBlock* block,
                 llvm::MemoryAccess* access,
                 MemoryDefinitionData::DefInfos& defs)
{
    if (llvm::MemoryUseOrDef* useOrDef = llvm::dyn_cast<llvm::MemoryUseOrDef>(access)) {
        auto* defInstr = useOrDef->getMemoryInst();
        block = defInstr->getParent() == block ? block : defInstr->getParent();
        defs.push_back(MemoryDefinitionData::DefInfo{block, useOrDef->getMemoryInst()});
        return;
    }
    if (llvm::MemoryPhi* phi = llvm::dyn_cast<llvm::MemoryPhi>(access)) {
        for (unsigned i = 0; i < phi->getNumIncomingValues(); ++i) {
            auto* incomingBlock = phi->getIncomingBlock(i);
            llvm::MemoryAccess* incomingAccess = phi->getIncomingValue(i);
            add_defData(incomingBlock, incomingAccess, defs);
        }
    }
}

}

MemoryDefinitionData::MemoryDefinitionData(llvm::Function& F,
                                           llvm::MemorySSA& ssa)
    : m_F(F)
    , m_memorySSA(ssa)
{
}

void MemoryDefinitionData::collectDefiningData()
{
    llvm::dbgs() << "Collecting defining blocks for " << m_F.getName() << "\n";
    for (auto& B : m_F) {
        for (auto& I : B) {
            auto& defData = m_definingBlocks[&I];
            llvm::MemoryAccess* useOrDef = m_memorySSA.getMemoryAccess(&I);
            if (!useOrDef) {
                continue;
            }
            llvm::MemoryUse* use = llvm::dyn_cast<llvm::MemoryUse>(useOrDef);
            if (!use) {
                continue;
            }
            llvm::MemoryAccess* definingAccess = use->getDefiningAccess();
            if (!definingAccess) {
                continue;
            }
            if (m_memorySSA.isLiveOnEntryDef(definingAccess)) {
                continue;
            }
            if (llvm::MemoryPhi* phiAccess = llvm::dyn_cast<llvm::MemoryPhi>(definingAccess)) {
                for (unsigned i = 0; i < phiAccess->getNumIncomingValues(); ++i) {
                    auto* incomingBlock = phiAccess->getIncomingBlock(i);
                    llvm::MemoryAccess* incomingAccess = phiAccess->getIncomingValue(i);
                    add_defData(incomingBlock, incomingAccess, defData);
                }
            } else if (llvm::MemoryDef* defAccess = llvm::dyn_cast<llvm::MemoryDef>(definingAccess)) {
                auto* defInst = defAccess->getMemoryInst();
                assert(defInst);
                defData.push_back(DefInfo{defInst->getParent(), defInst});
            }
        }
    }
}

const MemoryDefinitionData::DefInfos&
MemoryDefinitionData::getDefinitionData(llvm::Instruction* I)
{
    return m_definingBlocks[I];
}

const MemoryDefinitionData::DefInfos&
MemoryDefinitionData::getDefinitionData(llvm::Instruction* I) const
{
    auto pos = m_definingBlocks.find(I);
    if (pos == m_definingBlocks.end()) {
        return DefInfos();
    }
    return pos->second;
}

class MemoryDefinitionDataWrapperPass : public llvm::ModulePass
{
public:
  static char ID;

  MemoryDefinitionDataWrapperPass()
    : llvm::ModulePass(ID)
  {
  }
    
  bool runOnModule(llvm::Module &M) override
  {
    for (auto& F : M) {
        if (F.isDeclaration()) {
            continue;
        }
        llvm::MemorySSA& ssa = getAnalysis<llvm::MemorySSAWrapperPass>(F).getMSSA();
        ssa.dump();
        MemoryDefinitionData ssa_data(F, ssa);
        ssa_data.collectDefiningData();
        dump(F, ssa_data);
    }
  }

  virtual void getAnalysisUsage(llvm::AnalysisUsage &AU) const override
  {
      AU.addRequired<llvm::MemorySSAWrapperPass>();
      AU.setPreservesAll();
  }

private:
    void dump(llvm::Function& F, const MemoryDefinitionData& ssa_data)
    {
        llvm::dbgs() << "SSA Definition data for function " << F.getName() << "\n";
        for (auto& B : F) {
            for (auto& I : B) {
                const auto& def_data = ssa_data.getDefinitionData(&I);
                if (!def_data.empty()) {
                    llvm::dbgs() << "Instr: " << I << " definition\n";
                    for (auto& data : def_data) {
                        llvm::dbgs() << "   B: " << data.defBlock->getName() << "\n";
                        llvm::dbgs() << "   DefInstr: " << *data.defInstr << "\n";
                    }
                }
            }
        }
    }

};

char MemoryDefinitionDataWrapperPass::ID = 0;
static llvm::RegisterPass<MemoryDefinitionDataWrapperPass>
    X("test-memoryssa", "Dumps Memory SSA information");



}

