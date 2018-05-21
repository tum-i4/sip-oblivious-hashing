#pragma once

#include <vector>
#include <unordered_map>

namespace llvm {
class MemorySSA;
class Instruction;
class BasicBlock;
class Function;
}

namespace oh {

class MemoryDefinitionBlocks
{
public:

    struct DefInfo {
        llvm::BasicBlock* defBlock;
        llvm::Instruction* defInstr;
    };
    using DefInfos = std::vector<DefInfo>;

public:
    MemoryDefinitionBlocks(llvm::Function& F, llvm::MemorySSA& ssa);


    void collectDefiningBlocks();
    const DefInfos& getDefinitionInfos(llvm::Instruction* I);

private:
    llvm::Function& m_F;
    llvm::MemorySSA& m_memorySSA;
    std::unordered_map<llvm::Instruction*, DefInfos> m_definingBlocks;
};

}

