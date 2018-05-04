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
    for (const auto& B : blocks) {
        llvm::dbgs() << B->getParent()->getName() << "  " << B->getName() << "\n";
    }
}

void dump(const std::string& label, const std::unordered_set<llvm::Instruction*> instructions)
{
    llvm::dbgs() << label << "\n";
    for (const auto& I : instructions) {
        llvm::dbgs() << I->getParent()->getName() << "  " << *I << "\n";
    }
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
    if (m_protectedBlocks.insert(B).second) {
        addNumberOfShortRangeProtectedBlocks(1);
    }
    eraseFromUnprotectedBlocks(B);
}

void OHStats::addUnprotectedLoopBlock(llvm::BasicBlock* B)
{
    if (m_protectedBlocks.find(B) != m_protectedBlocks.end()
        || m_nonHashableBlocks.find(B) != m_nonHashableBlocks.end()) {
        return;
    }
    if (m_unprotectedLoopBlocks.insert(B).second) {
        addNumberOfUnprotectedLoopBlocks(1);
    }
}

void OHStats::addNonHashableBlock(llvm::BasicBlock* B)
{
    assert(m_protectedBlocks.find(B) == m_protectedBlocks.end());
    if (m_nonHashableBlocks.insert(B).second) {
        addNumberOfNonHashableBlocks(1);
    }
    if (m_unprotectedLoopBlocks.erase(B)) {
        addNumberOfUnprotectedLoopBlocks(-1);
    }
}

void OHStats::addUnprotectedDataDependentBlock(llvm::BasicBlock* B)
{
    if (m_unprotectedDataDependentBlocks.insert(B).second) {
        addNumberOfUnprotectedDataDependentBlocks(1);
        numberOfUnprotectedInputDependentInstructions += B->getInstList().size();
    }
}

void OHStats::addShortRangeProtectedInstruction(llvm::Instruction* I)
{
    if (m_shortRangeProtectedInstructions.insert(I).second) {
        numberOfShortRangeProtectedInstructions += 1;
    }
    m_unprotectedArgumentReachableInstructions.erase(I);
}

void OHStats::addDataDependentInstruction(llvm::Instruction* I)
{
    if (m_dataDependentInstructions.insert(I).second) {
        numberOfDataDependentInstructions += 1;
    }
}

void OHStats::addNonHashableInstruction(llvm::Instruction* I)
{
    m_nonHashableInstructions.insert(I);
}

void OHStats::addUnprotectedArgumentReachableInstruction(llvm::Instruction* I)
{
    // if I is protected by global OH this function won't get called for it.
    if (m_shortRangeProtectedInstructions.find(I) == m_shortRangeProtectedInstructions.end()) {
        m_unprotectedArgumentReachableInstructions.insert(I);
    }
}

void OHStats::eraseFromUnprotectedBlocks(llvm::BasicBlock* B)
{
    if (m_unprotectedLoopBlocks.erase(B)) {
        addNumberOfUnprotectedLoopBlocks(-1);
    }
    // TODO: non hashable Block can not becme hashable
    if (m_nonHashableBlocks.erase(B)) {
        addNumberOfNonHashableBlocks(-1);
    }
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
void OHStats::addNumberOfImplicitlyProtectedInstructions(int value){
	this->numberOfImplicitlyProtectedInstructions += value;
}
void OHStats::addNumberOfProtectedGuardInstructions(int value){
	this->numberOfProtectedGuardInstructions+=value;
}

void OHStats::addNumberOfShortRangeImplicitlyProtectedInstructions(int value)
{
	numberOfShortRangeImplicitlyProtectedInstructions += value;
}

void OHStats::addNumberOfShortRangeProtectedInstructions(int value)
{
	numberOfShortRangeProtectedInstructions += value;
}

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

void OHStats::addNumberOfUnprotectedLoopBlocks(int value)
{
    numberOfUnprotectedLoopBlocks += value;
}

void OHStats::addNumberOfNonHashableBlocks(int value)
{
    numberOfNonHashableBlocks += value;
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

void OHStats::addNumberOfNonHashableInstructions(int value)
{
    numberOfNonHashableInstructions += value;
}

void OHStats::addNumberOfUnprotectedLoopInstructions(int value)
{
    numberOfUnprotectedLoopInstructions += value;
}

void OHStats::addNumberOfUnprotectedInputDependentInstructions(int value)
{
    numberOfUnprotectedInputDependentInstructions += value;
}

void OHStats::addUnprotectedLoopInstructions()
{
    for (auto& B : m_unprotectedLoopBlocks) {
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
	j["numberOfUnprotectedLoopBlocks"] = numberOfUnprotectedLoopBlocks;
	j["numberOfNonHashableBlocks"] = numberOfNonHashableBlocks;
	j["numberOfUnprotectedDataDependentBlocks"] = numberOfUnprotectedDataDependentBlocks;

    j["numberOfSensitiveFunctions"] = numberOfSensitiveFunctions;
    j["numberOfProtectedFunctions"] = numberOfProtectedFunctions;
    j["numberOfSensitivePaths"] = numberOfSensitivePaths;
    j["numberOfProtectedPaths"] = numberOfProtectedPaths;
    if (numberOfNonHashableInstructions == 0) {
        numberOfNonHashableInstructions = m_nonHashableInstructions.size();
    }
    j["numberOfNonHashableInstructions"] = numberOfNonHashableInstructions;
    j["numberOfUnprotectedLoopInstructions"] = numberOfUnprotectedLoopInstructions;
    j["numberOfDataDependentInstructions"] = numberOfDataDependentInstructions;
    if (numberOfUnprotectedArgumentReachableInstructions == 0) {
        numberOfUnprotectedArgumentReachableInstructions = m_unprotectedArgumentReachableInstructions.size();
    }
    j["numberOfUnprotectedArgumentReachableInstructions"] = numberOfUnprotectedArgumentReachableInstructions;
    j["numberOfUnprotectedInputDependentInstructions"] = numberOfUnprotectedInputDependentInstructions;

	std::cout << j.dump(4) << std::endl;
	std::ofstream o(filePath);
	o << std::setw(4) << j << std::endl;

    //dumpBlocks();
    //dumpInstructions();
}

void OHStats::dumpBlocks()
{
    dump("Protected Blocks", m_protectedBlocks);
    dump("Unprotected loop Blocks", m_unprotectedLoopBlocks);
    dump("Non-hashable Blocks", m_nonHashableBlocks);
}

void OHStats::dumpInstructions()
{
    dump("Short range protected instructions", m_shortRangeProtectedInstructions);
    dump("data dependent instructions", m_dataDependentInstructions);
    dump("non hashable instructions", m_nonHashableInstructions);
    dump("unprotected argument reachable instructions", m_unprotectedArgumentReachableInstructions);
}

}
