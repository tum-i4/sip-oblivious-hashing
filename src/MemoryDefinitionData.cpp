#include "MemoryDefinitionData.h"

#include "llvm/Transforms/Utils/MemorySSA.h"
#include "llvm/IR/BasicBlock.h"
#include "llvm/Support/Casting.h"
#include "llvm/IR/Instructions.h"

namespace oh {

namespace {

void add_defData(llvm::BasicBlock* block,
                 llvm::MemoryAccess* access,
                 MemoryDefinitionData::DefInfos& defs)
{
    if (llvm::MemoryUseOrDef* useOrDef = llvm::dyn_cast<llvm::MemoryUseOrDef>(access)) {
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

void MemoryDefinitionData::collectDefiningBlocks()
{
    llvm::dbgs() << "Collecting defining blocks for " << m_F.getName() << "\n";
    m_memorySSA.dump();
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
MemoryDefinitionData::getDefinitionInfos(llvm::Instruction* I)
{
    return m_definingBlocks[I];
}

}

