#include "MemoryDefinitionData.h"

#include "llvm/Analysis/MemorySSA.h"
#include "llvm/IR/BasicBlock.h"
#include "llvm/Support/Casting.h"
#include "llvm/IR/Instructions.h"

#include "llvm/Pass.h"
#include "llvm/Transforms/IPO/PassManagerBuilder.h"
#include "llvm/IR/LegacyPassManager.h"

#include <unordered_set>

namespace oh {

namespace {

void add_defData(llvm::Instruction* instr,
                 llvm::BasicBlock* block,
                 llvm::MemoryAccess* access,
                 MemoryDefinitionData::DefInfos& defs,
                 std::unordered_set<llvm::MemoryAccess*>& processed_accesses)
{
    if (!processed_accesses.insert(access).second) {
        return;
    }
    if (llvm::MemoryDef* def = llvm::dyn_cast<llvm::MemoryDef>(access)) {
        auto* defInstr = def->getMemoryInst();
        if (!defInstr) {
            return;
        }
        block = defInstr->getParent() == block ? block : defInstr->getParent();
        if (auto* store = llvm::dyn_cast<llvm::StoreInst>(defInstr)) {
            if (auto* load = llvm::dyn_cast<llvm::LoadInst>(instr)) {
                if (store->getPointerOperand() == load->getOperand(0)) {
                    defs.push_back(MemoryDefinitionData::DefInfo{block, def->getMemoryInst()});
                    return;
                }
            }
        }
        for (auto it = def->defs_begin(); it != def->defs_end(); ++it) {
            llvm::MemoryAccess* def_access = *it;
            if (llvm::dyn_cast<llvm::MemoryDef>(def_access)) {
                defs.push_back(MemoryDefinitionData::DefInfo{block, def->getMemoryInst()});
            } else {
                add_defData(instr, def_access->getBlock(), def_access, defs, processed_accesses);
            }
        }
        return;
    }
    if (llvm::MemoryPhi* phi = llvm::dyn_cast<llvm::MemoryPhi>(access)) {
        for (unsigned i = 0; i < phi->getNumIncomingValues(); ++i) {
            auto* incomingBlock = phi->getIncomingBlock(i);
            llvm::MemoryAccess* incomingAccess = phi->getIncomingValue(i);
            add_defData(instr, incomingBlock, incomingAccess, defs, processed_accesses);
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
            std::unordered_set<llvm::MemoryAccess*> processed_accesses;
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
            processed_accesses.insert(definingAccess);
            if (m_memorySSA.isLiveOnEntryDef(definingAccess)) {
                continue;
            }
            if (llvm::MemoryPhi* phiAccess = llvm::dyn_cast<llvm::MemoryPhi>(definingAccess)) {
                for (unsigned i = 0; i < phiAccess->getNumIncomingValues(); ++i) {
                    auto* incomingBlock = phiAccess->getIncomingBlock(i);
                    llvm::MemoryAccess* incomingAccess = phiAccess->getIncomingValue(i);
                    add_defData(&I, incomingBlock, incomingAccess, defData, processed_accesses);
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

