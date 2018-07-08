#include "json.hpp"
#include <unordered_set>

namespace llvm {
class BasicBlock;
class Instruction;
class Function;
}

namespace oh {

class OHStats
{
private:
    int numberOfImplicitlyProtectedInstructions=0;
    int numberOfProtectedInstructions=0;
    int numberOfProtectedArguments=0;
    int numberOfHashVariables=0;
    int numberOfHashCalls =0;
    int numberOfAssertCalls = 0;
    int numberOfProtectedGuardInstructions = 0;
    int numberOfProtectedGuardArguments = 0;

    int numberOfShortRangeImplicitlyProtectedInstructions=0;
    int numberOfShortRangeProtectedInstructions=0;
    int numberOfShortRangeProtectedArguments=0;
    int numberOfShortRangeHashCalls =0;
    int numberOfShortRangeAssertCalls = 0;
    int numberOfShortRangeProtectedGuardInstructions = 0;
    int numberOfShortRangeProtectedGuardArguments = 0;

    int numberOfSensitiveBlocks = 0;
    int numberOfProtectedBlocks = 0;
    int numberOfShortRangeProtectedBlocks = 0;
    int numberOfUnprotectedDataDependentBlocks = 0;

    int numberOfSensitivePaths = 0;
    int numberOfProtectedPaths = 0;
    int numberOfSensitiveFunctions = 0;
    int numberOfProtectedFunctions = 0;

    int numberOfUnprotectedLoopInstructions = 0;
    int numberOfDataDependentInstructions = 0;
    int numberOfUnprotectedArgumentReachableInstructions = 0;
    int numberOfUnprotectedGlobalReachableInstructions = 0;
    int numberOfUnprotectedInputDependentInstructions = 0;

    using BasicBlocksSet = std::unordered_set<llvm::BasicBlock*>;
    BasicBlocksSet m_protectedBlocks;
    BasicBlocksSet m_shortRangeProtectedBlocks;
    BasicBlocksSet m_unprotectedArgumentReachableLoopBlocks;
    BasicBlocksSet m_unprotectedGlobalReachableLoopBlocks;
    BasicBlocksSet m_unprotectedDataDependentLoopBlocks;
    BasicBlocksSet m_nonHashableBlocks;
    BasicBlocksSet m_unprotectedDataDependentBlocks;
    using InstructionSet = std::unordered_set<llvm::Instruction*>;
    InstructionSet m_ohProtectedInstructions;
    InstructionSet m_shortRangeProtectedInstructions;
    InstructionSet m_dataDependentInstructions;
    InstructionSet m_nonHashableInstructions;
    InstructionSet m_unprotectedArgumentReachableInstructions;
    InstructionSet m_unprotectedGlobalReachableInstructions;
    InstructionSet m_unprotectedInstructions;
    InstructionSet m_unprotectedLoopVariantInstructions;
    InstructionSet m_scProtectedGuardInstructions;

    using FunctionSet = std::unordered_set<llvm::Function*>;
    FunctionSet m_functionsWithNoDG;
    FunctionSet m_filteredFunctions;
    FunctionSet m_functionsWithNoInputDep;

private:
    void addUnprotectedLoopInstructions();
    void addUnprotectedLoopInstructions(const BasicBlocksSet& blocks);
    void dumpBlocks();
    void dumpInstructions();
    void check_statistics_validity();
    void addUnprotectedLoopBlock(BasicBlocksSet& unprotectedLoopBlocks, llvm::BasicBlock* B);
    void removeFromUnprotectedLoopBlocks(llvm::BasicBlock* B);
    bool isUnprotectedLoopBlock(llvm::BasicBlock* B) const;

public:
    void addProtectedBlock(llvm::BasicBlock* B);
    void addShortRangeOHProtectedBlock(llvm::BasicBlock* B);
    void addUnprotectedArgumentReachableLoopBlock(llvm::BasicBlock* B);
    void addUnprotectedGlobalReachableLoopBlock(llvm::BasicBlock* B);
    void addUnprotectedDataDependentLoopBlock(llvm::BasicBlock* B);
    void addNonHashableBlock(llvm::BasicBlock* B);
    void addUnprotectedDataDependentBlock(llvm::BasicBlock* B);

    void addOhProtectedInstruction(llvm::Instruction* I);
    void addShortRangeProtectedInstruction(llvm::Instruction* I);
    void addDataDependentInstruction(llvm::Instruction* I);
    void addNonHashableInstruction(llvm::Instruction* I);
    void addUnprotectedArgumentReachableInstruction(llvm::Instruction* I);
    void addUnprotectedGlobalReachableInstruction(llvm::Instruction* I);
    void addUnprotectedInstruction(llvm::Instruction* I);
    void addUnprotectedLoopVariantInstruction(llvm::Instruction* I);

    void addSCProtectedGuardInstr(llvm::Instruction* I, int checkeeSize, int protectedArguments);
    void addSCShortRangeProtectedProtectedGuardInstr(llvm::Instruction* I, int checkeeSize, int protectedArguments);

    void addFunctionWithNoDg(llvm::Function* F);
    void addFilteredFunction(llvm::Function* F);
    void addFunctionWithNoInputDep(llvm::Function* F);

    void eraseFromUnprotectedBlocks(llvm::BasicBlock* B);

    void addNumberOfImplicitlyProtectedInstructions(llvm::Instruction* guardInst, int);
    void addNumberOfProtectedInstructions(int);
    void addNumberOfProtectedArguments(int);
    void setNumberOfHashVariables(int);
    void addNumberOfHashCalls(int);
    void addNumberOfAssertCalls(int);
    void addNumberOfProtectedGuardInstructions(int);
    void addNumberOfProtectedGuardArguments(int);

    void addNumberOfShortRangeImplicitlyProtectedInstructions(llvm::Instruction* guardInst, int);
    void addNumberOfShortRangeProtectedArguments(int);
    void addNumberOfShortRangeHashCalls(int);
    void addNumberOfShortRangeAssertCalls(int);
    void addNumberOfShortRangeProtectedGuardInstructions(int);
    void addNumberOfShortRangeProtectedGuardArguments(int);

    void addNumberOfSensitiveBlocks(int);
    void addNumberOfProtectedBlocks(int);
    void addNumberOfShortRangeProtectedBlocks(int);
    void addNumberOfUnprotectedLoopBlocks(int);
    void addNumberOfUnprotectedDataDependentBlocks(int);

    void addNumberOfSensitiveFunctions(int);
    void addNumberOfProtectedFunctions(int);
    void addNumberOfSensitivePaths(int);
    void addNumberOfProtectedPaths(int);

    void dumpJson(std::string fileName);
};

} // namespace oh
