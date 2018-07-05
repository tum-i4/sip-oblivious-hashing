#include "Stats.h"

#include "llvm/IR/Function.h"
#include "llvm/IR/BasicBlock.h"
#include "llvm/Support/Debug.h"
#include "llvm/Support/raw_ostream.h"

#include <fstream>

namespace {

void dump(const std::string& label, const std::unordered_set<llvm::BasicBlock*> blocks)
{
    llvm::dbgs() << label << "\n";
    llvm::dbgs() << "------------------------\n";
    for (const auto& B : blocks) {
        llvm::dbgs() << B->getParent()->getName() << "  " << B->getName() << "\n";
    }
}

void dump(const std::string& label, const std::unordered_set<llvm::Instruction*> instructions)
{
    //llvm::dbgs() << label << "\n";
    //llvm::dbgs() << "------------------------\n";
    for (const auto& I : instructions) {
        llvm::dbgs() << I->getParent()->getParent()->getName() << I->getParent()->getName() << *I << "\n";
        //llvm::dbgs() << I->getParent()->getParent()->getName() << " " << *I << "\n";
    }
}

void dump(const llvm::BasicBlock::InstListType& instructions)
{
    for (const auto& I : instructions) {
        llvm::dbgs() << I.getParent()->getParent()->getName() << I.getParent()->getName() << I << "\n";
    }
}

void dump_instructions(const std::unordered_set<llvm::BasicBlock*> blocks)
{
    for (auto& B : blocks) {
        dump(B->getInstList());
    }
}

void dump_instructions(const std::unordered_set<llvm::Function*> functions)
{
    for (auto& F : functions) {
        for (auto& B : *F) {
            dump(B.getInstList());
        }
    }
}

int getNumberOfInstructionsInFunctions(const std::unordered_set<llvm::Function*>& functions)
{
    int number = 0;
    for (auto& F : functions) {
        for (auto& B : *F) {
            number += B.getInstList().size();
        }
    }
    return number;
}

}

namespace oh {

using json = nlohmann::json;

void OHStats::addProtectedBlock(llvm::BasicBlock* B)
{
    if (m_protectedBlocks.insert(B).second) {
        addNumberOfProtectedBlocks(1);
    }
    eraseFromUnprotectedBlocks(B);
}

void OHStats::addShortRangeOHProtectedBlock(llvm::BasicBlock* B)
{
    if (m_protectedBlocks.find(B) != m_protectedBlocks.end()) {
        return;
    }
    if (m_protectedBlocks.insert(B).second) {
        addNumberOfShortRangeProtectedBlocks(1);
    }
    eraseFromUnprotectedBlocks(B);
}

void OHStats::addUnprotectedArgumentReachableLoopBlock(llvm::BasicBlock* B)
{
    if (m_unprotectedGlobalReachableLoopBlocks.find(B) != m_unprotectedGlobalReachableLoopBlocks.end()
        || m_unprotectedDataDependentLoopBlocks.find(B) != m_unprotectedDataDependentLoopBlocks.end()) {
        return;
    }
    addUnprotectedLoopBlock(m_unprotectedArgumentReachableLoopBlocks,
                            B);
}

void OHStats::addUnprotectedGlobalReachableLoopBlock(llvm::BasicBlock* B)
{
    if (m_unprotectedArgumentReachableLoopBlocks.find(B) != m_unprotectedArgumentReachableLoopBlocks.end()
        || m_unprotectedDataDependentLoopBlocks.find(B) != m_unprotectedDataDependentLoopBlocks.end()) {
        return;
    }
    addUnprotectedLoopBlock(m_unprotectedGlobalReachableLoopBlocks,
                            B);
}

void OHStats::addUnprotectedDataDependentLoopBlock(llvm::BasicBlock* B)
{
    if (m_unprotectedArgumentReachableLoopBlocks.find(B) != m_unprotectedArgumentReachableLoopBlocks.end()) {
        m_unprotectedArgumentReachableLoopBlocks.erase(B);
    }
    if (m_unprotectedGlobalReachableLoopBlocks.find(B) != m_unprotectedGlobalReachableLoopBlocks.end()) {
        m_unprotectedGlobalReachableLoopBlocks.erase(B);
    }

    addUnprotectedLoopBlock(m_unprotectedDataDependentLoopBlocks,
                            B);
}

void OHStats::addUnprotectedLoopBlock(BasicBlocksSet& unprotectedLoopBlocks,
                                      llvm::BasicBlock* B)
{
    if (m_protectedBlocks.find(B) != m_protectedBlocks.end()
        || m_nonHashableBlocks.find(B) != m_nonHashableBlocks.end()
        || m_unprotectedDataDependentBlocks.find(B) != m_unprotectedDataDependentBlocks.end()) {
        return;
    }
    unprotectedLoopBlocks.insert(B);
}

void OHStats::removeFromUnprotectedLoopBlocks(llvm::BasicBlock* B)
{
    m_unprotectedArgumentReachableLoopBlocks.erase(B);
    m_unprotectedGlobalReachableLoopBlocks.erase(B);
    m_unprotectedDataDependentLoopBlocks.erase(B);
}

bool OHStats::isUnprotectedLoopBlock(llvm::BasicBlock* B) const
{
    return (m_unprotectedArgumentReachableLoopBlocks.find(B) != m_unprotectedArgumentReachableLoopBlocks.end()
            || m_unprotectedGlobalReachableLoopBlocks.find(B) != m_unprotectedGlobalReachableLoopBlocks.end()
            || m_unprotectedDataDependentLoopBlocks.find(B) != m_unprotectedDataDependentLoopBlocks.end());
}

void OHStats::addNonHashableBlock(llvm::BasicBlock* B)
{
    if (m_protectedBlocks.find(B) != m_protectedBlocks.end()) {
        return;
    }
    m_nonHashableBlocks.insert(B);
    m_unprotectedDataDependentBlocks.erase(B);
    removeFromUnprotectedLoopBlocks(B);
}

void OHStats::addUnprotectedDataDependentBlock(llvm::BasicBlock* B)
{
    if (m_nonHashableBlocks.find(B) != m_nonHashableBlocks.end()
        || m_protectedBlocks.find(B) != m_protectedBlocks.end()
        || isUnprotectedLoopBlock(B)) {
        return;
    }
    if (m_unprotectedDataDependentBlocks.insert(B).second) {
        addNumberOfUnprotectedDataDependentBlocks(1);
        numberOfUnprotectedInputDependentInstructions += B->getInstList().size();
    }
}

void OHStats::addOhProtectedInstruction(llvm::Instruction* I)
{
    m_ohProtectedInstructions.insert(I);
    addNumberOfProtectedInstructions(1);
}

void OHStats::addShortRangeProtectedInstruction(llvm::Instruction* I)
{
    if (m_shortRangeProtectedInstructions.insert(I).second) {
        numberOfShortRangeProtectedInstructions += 1;
    }
    if (m_unprotectedArgumentReachableInstructions.erase(I)) {
        numberOfUnprotectedArgumentReachableInstructions += -1;
    }
    if (m_unprotectedGlobalReachableInstructions.erase(I)) {
        numberOfUnprotectedGlobalReachableInstructions += -1;
    }
    m_unprotectedInstructions.erase(I);
    if (m_dataDependentInstructions.erase(I)) {
        numberOfDataDependentInstructions += -1;
    }
}

void OHStats::addDataDependentInstruction(llvm::Instruction* I)
{
    if (m_dataDependentInstructions.insert(I).second) {
        numberOfDataDependentInstructions += 1;
    }
    m_unprotectedArgumentReachableInstructions.erase(I);
    m_unprotectedGlobalReachableInstructions.erase(I);
    m_unprotectedInstructions.erase(I);
    m_nonHashableInstructions.erase(I);
}

void OHStats::addNonHashableInstruction(llvm::Instruction* I)
{
    if (m_dataDependentInstructions.find(I) != m_dataDependentInstructions.end()) {
        return;
    }
    if (m_unprotectedArgumentReachableInstructions.find(I) != m_unprotectedArgumentReachableInstructions.end()){
        return;
    }
    if (m_unprotectedGlobalReachableInstructions.find(I) != m_unprotectedGlobalReachableInstructions.end()){
        return;
    }
    m_unprotectedInstructions.erase(I);
    if (m_nonHashableInstructions.insert(I).second) {
        numberOfNonHashableInstructions += 1;
    }
}

void OHStats::addUnprotectedArgumentReachableInstruction(llvm::Instruction* I)
{
    if (m_dataDependentInstructions.find(I) != m_dataDependentInstructions.end()) {
        return;
    }
    if (m_shortRangeProtectedInstructions.find(I) != m_shortRangeProtectedInstructions.end()) {
        return;
    }
    if (m_unprotectedGlobalReachableInstructions.find(I) != m_unprotectedGlobalReachableInstructions.end()) {
        return;
    }
    if (m_nonHashableInstructions.find(I) != m_nonHashableInstructions.end()) {
        return;
    }
    m_unprotectedInstructions.erase(I);
    // if I is protected by global OH this function won't get called for it.
    if (m_unprotectedArgumentReachableInstructions.insert(I).second) {
        numberOfUnprotectedArgumentReachableInstructions += 1;
    }
}

void OHStats::addUnprotectedGlobalReachableInstruction(llvm::Instruction* I)
{
    // if I is protected by global OH this function won't get called for it.
    if (m_dataDependentInstructions.find(I) != m_dataDependentInstructions.end()) {
        return;
    }
    if (m_shortRangeProtectedInstructions.find(I) != m_shortRangeProtectedInstructions.end()) {
        return;
    }
    if (m_unprotectedArgumentReachableInstructions.find(I) != m_unprotectedArgumentReachableInstructions.end()) {
        return;
    }
    if (m_nonHashableInstructions.find(I) != m_nonHashableInstructions.end()) {
        return;
    }
    m_unprotectedInstructions.erase(I);
    if (m_unprotectedGlobalReachableInstructions.insert(I).second) {
        numberOfUnprotectedGlobalReachableInstructions += 1;
    }
}

void OHStats::addUnprotectedInstruction(llvm::Instruction* I)
{
    if (m_dataDependentInstructions.find(I) != m_dataDependentInstructions.end()) {
        return;
    }

    if (m_shortRangeProtectedInstructions.find(I) == m_shortRangeProtectedInstructions.end()
            && m_unprotectedArgumentReachableInstructions.find(I) == m_unprotectedArgumentReachableInstructions.end()
            && m_unprotectedGlobalReachableInstructions.find(I) == m_unprotectedGlobalReachableInstructions.end()
            && m_nonHashableInstructions.find(I) == m_nonHashableInstructions.end()) {
        m_unprotectedInstructions.insert(I);
    }
}

void OHStats::addFunctionWithNoDg(llvm::Function* F)
{
    m_functionsWithNoDG.insert(F);
}

void OHStats::addFilteredFunction(llvm::Function* F)
{
    m_filteredFunctions.insert(F);
}

void OHStats::addFunctionWithNoInputDep(llvm::Function* F)
{
    m_functionsWithNoInputDep.insert(F);
}

void OHStats::eraseFromUnprotectedBlocks(llvm::BasicBlock* B)
{
    removeFromUnprotectedLoopBlocks(B);
    m_nonHashableBlocks.erase(B);
    m_unprotectedDataDependentBlocks.erase(B);
}

void OHStats::addNumberOfProtectedGuardArguments(int value){
	this->numberOfProtectedGuardArguments += value;
}
void OHStats::addNumberOfProtectedInstructions(int value){
	this->numberOfProtectedInstructions += value;
}
void OHStats::addNumberOfProtectedArguments(int value){
	this->numberOfProtectedArguments += value;
}
void OHStats::setNumberOfHashVariables(int value){
	this->numberOfHashVariables=value;
}
void OHStats::addNumberOfHashCalls(int value){
	this->numberOfHashCalls += value;
}
void OHStats::addNumberOfAssertCalls(int value){
	this->numberOfAssertCalls += value;
}
void OHStats::addNumberOfImplicitlyProtectedInstructions(llvm::Instruction* guardInst, int value){
    if (m_scProtectedGuardInstructions.insert(guardInst).second) {
        this->numberOfImplicitlyProtectedInstructions += value;
        addNumberOfProtectedGuardInstructions(1);
    }
}
void OHStats::addNumberOfProtectedGuardInstructions(int value){
	this->numberOfProtectedGuardInstructions+=value;
}

void OHStats::addNumberOfShortRangeImplicitlyProtectedInstructions(llvm::Instruction* guardInst, int value)
{
    if (m_scProtectedGuardInstructions.insert(guardInst).second) {
        numberOfShortRangeImplicitlyProtectedInstructions += value;
        addNumberOfShortRangeProtectedGuardInstructions(1);
    }
}

void OHStats::addSCProtectedGuardInstr(llvm::Instruction* I, int checkeeSize, int protectedArguments)
{
    if (m_scProtectedGuardInstructions.insert(I).second) {
        this->numberOfImplicitlyProtectedInstructions += checkeeSize;
        addNumberOfProtectedGuardInstructions(1);
        addNumberOfProtectedGuardArguments(protectedArguments);
    }
}

void OHStats::addSCShortRangeProtectedProtectedGuardInstr(llvm::Instruction* I, int checkeeSize, int protectedArguments)
{
    if (m_scProtectedGuardInstructions.insert(I).second) {
        numberOfShortRangeImplicitlyProtectedInstructions += checkeeSize;
        addNumberOfShortRangeProtectedGuardInstructions(1);
        addNumberOfShortRangeProtectedGuardArguments(protectedArguments);
    }
}


//void OHStats::addNumberOfShortRangeProtectedInstructions(int value)
//{
//	numberOfShortRangeProtectedInstructions += value;
//}

void OHStats::addNumberOfShortRangeProtectedArguments(int value)
{
	numberOfShortRangeProtectedArguments += value;
}

void OHStats::addNumberOfShortRangeHashCalls(int value)
{
	numberOfShortRangeHashCalls += value;
}

void OHStats::addNumberOfShortRangeAssertCalls(int value)
{
	numberOfShortRangeAssertCalls += value;
}

void OHStats::addNumberOfShortRangeProtectedGuardInstructions(int value)
{
	numberOfShortRangeProtectedGuardInstructions += value;
}

void OHStats::addNumberOfShortRangeProtectedGuardArguments(int value)
{
	numberOfShortRangeProtectedGuardArguments += value;
}

void OHStats::addNumberOfSensitiveBlocks(int value)
{
    numberOfSensitiveBlocks += value;
}

void OHStats::addNumberOfProtectedBlocks(int value)
{
    numberOfProtectedBlocks += value;
}

void OHStats::addNumberOfShortRangeProtectedBlocks(int value)
{
    numberOfShortRangeProtectedBlocks += value;
}

void OHStats::addNumberOfUnprotectedDataDependentBlocks(int value)
{
    numberOfUnprotectedDataDependentBlocks += value;
}

void OHStats::addNumberOfSensitiveFunctions(int value)
{
    numberOfSensitiveFunctions += value;
}

void OHStats::addNumberOfProtectedFunctions(int value)
{
    numberOfProtectedFunctions += value;
}

void OHStats::addNumberOfSensitivePaths(int value)
{
    numberOfSensitivePaths += value;
}

void OHStats::addNumberOfProtectedPaths(int value)
{
    numberOfProtectedPaths += value;
}

void OHStats::addUnprotectedLoopInstructions()
{
    addUnprotectedLoopInstructions(m_unprotectedArgumentReachableLoopBlocks);
    addUnprotectedLoopInstructions(m_unprotectedGlobalReachableLoopBlocks);
    addUnprotectedLoopInstructions(m_unprotectedDataDependentLoopBlocks);
}

void OHStats::addUnprotectedLoopInstructions(const BasicBlocksSet& blocks)
{
    for (auto& B : blocks) {
        numberOfUnprotectedLoopInstructions += B->getInstList().size();
    }
}

void OHStats::dumpJson(std::string filePath){
    addUnprotectedLoopInstructions();

	json j;
	j["numberOfImplicitlyProtectedInstructions"] = numberOfImplicitlyProtectedInstructions;
	j["numberOfProtectedInstructions"] = numberOfProtectedInstructions;
	j["numberOfProtectedArguments"] = numberOfProtectedArguments;
	j["numberOfHashVariables"] = numberOfHashVariables;
	j["numberOfHashCalls"] = numberOfHashCalls;
	j["numberOfAssertCalls"] = numberOfAssertCalls;
	j["numberOfProtectedGuardInstructions"] = numberOfProtectedGuardInstructions;
	j["numberOfProtectedGuardArguments"] = numberOfProtectedGuardArguments;

	j["numberOfShortRangeImplicitlyProtectedInstructions"] = numberOfShortRangeImplicitlyProtectedInstructions;
	j["numberOfShortRangeProtectedInstructions"] = numberOfShortRangeProtectedInstructions;
	j["numberOfShortRangeProtectedArguments"] = numberOfShortRangeProtectedArguments;
	j["numberOfShortRangeHashCalls"] = numberOfShortRangeHashCalls;
	j["numberOfShortRangeAssertCalls"] = numberOfShortRangeAssertCalls;
	j["numberOfShortRangeProtectedGuardInstructions"] = numberOfShortRangeProtectedGuardInstructions;
	j["numberOfShortRangeProtectedGuardArguments"] = numberOfShortRangeProtectedGuardArguments;

	j["numberOfSensitiveBlocks"] = numberOfSensitiveBlocks;
	j["numberOfProtectedBlocks"] = numberOfProtectedBlocks;
	j["numberOfShortRangeProtectedBlocks"] = numberOfShortRangeProtectedBlocks;
	j["numberOfUnprotectedDataDependentLoopBlocks"] = m_unprotectedDataDependentLoopBlocks.size();
	j["numberOfUnprotectedArgumentReachableLoopBlocks"] = m_unprotectedArgumentReachableLoopBlocks.size();
	j["numberOfUnprotectedGlobalReachableLoopBlocks"] = m_unprotectedGlobalReachableLoopBlocks.size();
	j["numberOfNonHashableBlocks"] = m_nonHashableBlocks.size();
	j["numberOfUnprotectedDataDependentBlocks"] = numberOfUnprotectedDataDependentBlocks;

    j["numberOfSensitiveFunctions"] = numberOfSensitiveFunctions;
    j["numberOfProtectedFunctions"] = numberOfProtectedFunctions;
    //j["numberOfSensitivePaths"] = numberOfSensitivePaths;
    //j["numberOfProtectedPaths"] = numberOfProtectedPaths;
    j["numberOfNonHashableInstructions"] = numberOfNonHashableInstructions;
    j["numberOfUnprotectedLoopInstructions"] = numberOfUnprotectedLoopInstructions;
    j["numberOfDataDependentInstructions"] = numberOfDataDependentInstructions;
    j["numberOfUnprotectedArgumentReachableInstructions"] = numberOfUnprotectedArgumentReachableInstructions;
    j["numberOfUnprotectedGlobalReachableInstructions"] = numberOfUnprotectedGlobalReachableInstructions;
    j["numberOfUnprotectedInputDependentInstructions"] = numberOfUnprotectedInputDependentInstructions;
    j["numberOfOtherUnprotectedInstructions"] = m_unprotectedInstructions.size();
    j["numberOfInstructionsInFilteredFunctions"] = getNumberOfInstructionsInFunctions(m_filteredFunctions);
    //j["numberOfInstructionsInFunctionsWithNoInputDep"] = getNumberOfInstructionsInFunctions(m_functionsWithNoInputDep);
    j["numberOfInstructionsInFunctionsWithNoDG"] = getNumberOfInstructionsInFunctions(m_functionsWithNoDG);

    int numberOfProcessedInstrs = getNumberOfInstructionsInFunctions(m_functionsWithNoDG)
        + getNumberOfInstructionsInFunctions(m_filteredFunctions)
        + numberOfUnprotectedInputDependentInstructions
        + numberOfUnprotectedGlobalReachableInstructions
        + numberOfUnprotectedArgumentReachableInstructions
        + numberOfDataDependentInstructions
        + numberOfUnprotectedLoopInstructions
        + numberOfNonHashableInstructions
        + numberOfShortRangeProtectedInstructions
        + numberOfProtectedInstructions
        +  m_unprotectedInstructions.size();
    llvm::dbgs() << "Processed instructions number " << numberOfProcessedInstrs << "\n";
    j["numberOfOHProcessedInstr"] = numberOfProcessedInstrs;

	std::cout << j.dump(4) << std::endl;
	std::ofstream o(filePath);
	o << std::setw(4) << j << std::endl;

    dumpBlocks();
    //dumpInstructions();
}

void OHStats::dumpBlocks()
{
    dump("Protected Blocks", m_protectedBlocks);
    dump("Unprotected data dependent loop Blocks", m_unprotectedDataDependentLoopBlocks);
    dump("Unprotected argument reachable loop Blocks", m_unprotectedArgumentReachableLoopBlocks);
    dump("Unprotected global reachable loop Blocks", m_unprotectedGlobalReachableLoopBlocks);
    dump("Non-hashable Blocks", m_nonHashableBlocks);
}

void OHStats::dumpInstructions()
{
    for (auto& I : m_ohProtectedInstructions) {
        assert(m_shortRangeProtectedInstructions.find(I) == m_shortRangeProtectedInstructions.end());
        assert(m_dataDependentInstructions.find(I) == m_dataDependentInstructions.end());
        assert(m_nonHashableInstructions.find(I) == m_nonHashableInstructions.end());
        assert(m_unprotectedArgumentReachableInstructions.find(I) == m_unprotectedArgumentReachableInstructions.end());
        assert(m_unprotectedGlobalReachableInstructions.find(I) == m_unprotectedGlobalReachableInstructions.end());
        assert(m_unprotectedInstructions.find(I) == m_unprotectedInstructions.end());
    }
    for (auto& I : m_shortRangeProtectedInstructions) {
        assert(m_ohProtectedInstructions.find(I) == m_ohProtectedInstructions.end());
        assert(m_dataDependentInstructions.find(I) == m_dataDependentInstructions.end());
        assert(m_nonHashableInstructions.find(I) == m_nonHashableInstructions.end());
        assert(m_unprotectedArgumentReachableInstructions.find(I) == m_unprotectedArgumentReachableInstructions.end());
        assert(m_unprotectedGlobalReachableInstructions.find(I) == m_unprotectedGlobalReachableInstructions.end());
        assert(m_unprotectedInstructions.find(I) == m_unprotectedInstructions.end());
    }
    for (auto& I : m_dataDependentInstructions) {
        assert(m_ohProtectedInstructions.find(I) == m_ohProtectedInstructions.end());
        assert(m_shortRangeProtectedInstructions.find(I) == m_shortRangeProtectedInstructions.end());
        assert(m_nonHashableInstructions.find(I) == m_nonHashableInstructions.end());
        assert(m_unprotectedArgumentReachableInstructions.find(I) == m_unprotectedArgumentReachableInstructions.end());
        assert(m_unprotectedGlobalReachableInstructions.find(I) == m_unprotectedGlobalReachableInstructions.end());
        assert(m_unprotectedInstructions.find(I) == m_unprotectedInstructions.end());
    }
    for (auto& I : m_nonHashableInstructions) {
        assert(m_ohProtectedInstructions.find(I) == m_ohProtectedInstructions.end());
        assert(m_shortRangeProtectedInstructions.find(I) == m_shortRangeProtectedInstructions.end());
        assert(m_dataDependentInstructions.find(I) == m_dataDependentInstructions.end());
        assert(m_unprotectedArgumentReachableInstructions.find(I) == m_unprotectedArgumentReachableInstructions.end());
        assert(m_unprotectedGlobalReachableInstructions.find(I) == m_unprotectedGlobalReachableInstructions.end());
        assert(m_unprotectedInstructions.find(I) == m_unprotectedInstructions.end());
    }
    for (auto& I : m_unprotectedArgumentReachableInstructions) {
        assert(m_ohProtectedInstructions.find(I) == m_ohProtectedInstructions.end());
        assert(m_shortRangeProtectedInstructions.find(I) == m_shortRangeProtectedInstructions.end());
        assert(m_dataDependentInstructions.find(I) == m_dataDependentInstructions.end());
        assert(m_nonHashableInstructions.find(I) == m_nonHashableInstructions.end());
        assert(m_unprotectedGlobalReachableInstructions.find(I) == m_unprotectedGlobalReachableInstructions.end());
        assert(m_unprotectedInstructions.find(I) == m_unprotectedInstructions.end());
    }
    for (auto& I : m_unprotectedGlobalReachableInstructions) {
        assert(m_ohProtectedInstructions.find(I) == m_ohProtectedInstructions.end());
        assert(m_shortRangeProtectedInstructions.find(I) == m_shortRangeProtectedInstructions.end());
        assert(m_dataDependentInstructions.find(I) == m_dataDependentInstructions.end());
        assert(m_nonHashableInstructions.find(I) == m_nonHashableInstructions.end());
        assert(m_unprotectedArgumentReachableInstructions.find(I) == m_unprotectedArgumentReachableInstructions.end());
        assert(m_unprotectedInstructions.find(I) == m_unprotectedInstructions.end());
    }
    for (auto& I : m_unprotectedInstructions) {
        assert(m_ohProtectedInstructions.find(I) == m_ohProtectedInstructions.end());
        assert(m_shortRangeProtectedInstructions.find(I) == m_shortRangeProtectedInstructions.end());
        assert(m_dataDependentInstructions.find(I) == m_dataDependentInstructions.end());
        assert(m_nonHashableInstructions.find(I) == m_nonHashableInstructions.end());
        assert(m_unprotectedArgumentReachableInstructions.find(I) == m_unprotectedArgumentReachableInstructions.end());
        assert(m_unprotectedGlobalReachableInstructions.find(I) == m_unprotectedGlobalReachableInstructions.end());
    }

    for (auto& B : m_protectedBlocks) {
        assert(m_unprotectedArgumentReachableLoopBlocks.find(B) == m_unprotectedArgumentReachableLoopBlocks.end());
        assert(m_unprotectedGlobalReachableLoopBlocks.find(B) == m_unprotectedGlobalReachableLoopBlocks.end());
        assert(m_unprotectedDataDependentLoopBlocks.find(B) == m_unprotectedDataDependentLoopBlocks.end());
        assert(m_nonHashableBlocks.find(B) == m_nonHashableBlocks.end());
        assert(m_unprotectedDataDependentBlocks.find(B) == m_unprotectedDataDependentBlocks.end());
    }
    for (auto& B : m_unprotectedArgumentReachableLoopBlocks) {
        assert(m_protectedBlocks.find(B) == m_protectedBlocks.end());
        assert(m_unprotectedGlobalReachableLoopBlocks.find(B) == m_unprotectedGlobalReachableLoopBlocks.end());
        assert(m_unprotectedDataDependentLoopBlocks.find(B) == m_unprotectedDataDependentLoopBlocks.end());
        assert(m_nonHashableBlocks.find(B) == m_nonHashableBlocks.end());
        assert(m_unprotectedDataDependentBlocks.find(B) == m_unprotectedDataDependentBlocks.end());
    }
    for (auto& B : m_unprotectedGlobalReachableLoopBlocks) {
        assert(m_protectedBlocks.find(B) == m_protectedBlocks.end());
        assert(m_unprotectedArgumentReachableLoopBlocks.find(B) == m_unprotectedArgumentReachableLoopBlocks.end());
        assert(m_unprotectedDataDependentLoopBlocks.find(B) == m_unprotectedDataDependentLoopBlocks.end());
        assert(m_nonHashableBlocks.find(B) == m_nonHashableBlocks.end());
        assert(m_unprotectedDataDependentBlocks.find(B) == m_unprotectedDataDependentBlocks.end());
    }
    for (auto& B : m_unprotectedDataDependentLoopBlocks) {
        assert(m_protectedBlocks.find(B) == m_protectedBlocks.end());
        assert(m_unprotectedArgumentReachableLoopBlocks.find(B) == m_unprotectedArgumentReachableLoopBlocks.end());
        assert(m_unprotectedGlobalReachableLoopBlocks.find(B) == m_unprotectedGlobalReachableLoopBlocks.end());
        assert(m_nonHashableBlocks.find(B) == m_nonHashableBlocks.end());
        assert(m_unprotectedDataDependentBlocks.find(B) == m_unprotectedDataDependentBlocks.end());
    }
    for (auto& B : m_nonHashableBlocks) {
        assert(m_protectedBlocks.find(B) == m_protectedBlocks.end());
        assert(m_unprotectedArgumentReachableLoopBlocks.find(B) == m_unprotectedArgumentReachableLoopBlocks.end());
        assert(m_unprotectedGlobalReachableLoopBlocks.find(B) == m_unprotectedGlobalReachableLoopBlocks.end());
        assert(m_unprotectedArgumentReachableLoopBlocks.find(B) == m_unprotectedDataDependentLoopBlocks.end());
        assert(m_unprotectedDataDependentBlocks.find(B) == m_unprotectedDataDependentBlocks.end());
    }
    for (auto& B : m_unprotectedDataDependentBlocks) {
        assert(m_protectedBlocks.find(B) == m_protectedBlocks.end());
        assert(m_unprotectedArgumentReachableLoopBlocks.find(B) == m_unprotectedArgumentReachableLoopBlocks.end());
        assert(m_unprotectedGlobalReachableLoopBlocks.find(B) == m_unprotectedGlobalReachableLoopBlocks.end());
        assert(m_unprotectedArgumentReachableLoopBlocks.find(B) == m_unprotectedDataDependentLoopBlocks.end());
        assert(m_nonHashableBlocks.find(B) == m_nonHashableBlocks.end());
    }
    //for (auto* I : m_shortRangeProtectedInstructions) {
    //    assert(m_nonHashableInstructions.find(I) == m_nonHashableInstructions.end());
    //    assert(m_dataDependentInstructions.find(I) == m_dataDependentInstructions.end());
    //    assert(m_unprotectedArgumentReachableInstructions.find(I) == m_unprotectedArgumentReachableInstructions.end());
    //    assert(m_unprotectedGlobalReachableInstructions.find(I) == m_unprotectedGlobalReachableInstructions.end());
    //}
    //dump("Oh protected instructions", m_ohProtectedInstructions);
    //dump("Short range protected instructions", m_shortRangeProtectedInstructions);
    //dump("data dependent instructions", m_dataDependentInstructions);
    //dump("non hashable instructions", m_nonHashableInstructions);
    //dump("unprotected argument reachable instructions", m_unprotectedArgumentReachableInstructions);
    //dump("unprotected global reachable instructions", m_unprotectedGlobalReachableInstructions);
    //dump("unprotected instructions", m_unprotectedInstructions);
    //dump_instructions(m_unprotectedArgumentReachableLoopBlocks);
    //dump_instructions(m_unprotectedGlobalReachableLoopBlocks);
    //dump_instructions(m_unprotectedDataDependentLoopBlocks);
    //dump_instructions(m_filteredFunctions);
    //dump_instructions(m_functionsWithNoDG);
}

}
