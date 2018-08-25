#pragma once

#include "oblivious-hashing/Stats.h"
#include "input-dependency/Analysis/InputDependencyAnalysisPass.h"

#include <vector>

namespace llvm {
class BasicBlock;
class Function;
class Instruction;
}

class FunctionInformation;

namespace oh {

class OHRunner : public llvm::ModulePass
{
public:
    static char ID;

    OHRunner()
        : llvm::ModulePass(ID)
        , m_hasTagsToSkip(false)
    {
    }

    bool runOnModule(llvm::Module &M) override;
    void getAnalysisUsage(llvm::AnalysisUsage &AU) const override;

protected:
    bool skipFunction(llvm::Function& F) const;
    bool skipInstruction(llvm::Instruction& I) const;
    bool skipBasicBlock(llvm::BasicBlock& B) const;
    bool hasSkipTag(llvm::Instruction& I) const;
    void parse_skip_tags(const std::string& SkipTaggedInstructions);
    void recordInstrumentedInstr();

    virtual bool instrumentInst() = 0;
    virtual bool instrumentInstArguments(llvm::Instruction& I) = 0;

protected:
    OHStats stats;
    using InputDependencyAnalysisType = input_dependency::InputDependencyAnalysisPass::InputDependencyAnalysisType;
    InputDependencyAnalysisType m_input_dependency_info;
    FunctionInformation* m_function_filter_info;
    std::vector<std::string> m_skipTags;
    bool m_hasTagsToSkip;
}; // class OHRunner

} // namespace oh

