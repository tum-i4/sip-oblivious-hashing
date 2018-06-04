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
    llvm::dbgs() << label << "\n";
    llvm::dbgs() << "------------------------\n";
    for (const auto& I : instructions) {
        llvm::dbgs() << I->getParent()->getParent()->getName() << " " << I->getParent()->getName() << "  " << *I << "\n";
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

void OHStats::addUnprotectedArgumentReachableLoopBlock(llvm::BasicBlock* B)
{
    addUnprotectedLoopBlock(m_unprotectedArgumentReachableLoopBlocks,
                            B);
}

void OHStats::addUnprotectedGlobalReachableLoopBlock(llvm::BasicBlock* B)
{
    addUnprotectedLoopBlock(m_unprotectedGlobalReachableLoopBlocks,
                            B);
}

void OHStats::addUnprotectedDataDependentLoopBlock(llvm::BasicBlock* B)
{
    addUnprotectedLoopBlock(m_unprotectedDataDependentLoopBlocks,
                            B);
}

void OHStats::addUnprotectedLoopBlock(BasicBlocksSet& unprotectedLoopBlocks,
                                      llvm::BasicBlock* B)
{
    if (m_protectedBlocks.find(B) != m_protectedBlocks.end()
        || m_nonHashableBlocks.find(B) != m_nonHashableBlocks.end()) {
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

void OHStats::addNonHashableBlock(llvm::BasicBlock* B)
{
    assert(m_protectedBlocks.find(B) == m_protectedBlocks.end());
    m_nonHashableBlocks.insert(B);
    removeFromUnprotectedLoopBlocks(B);
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
    if (m_unprotectedArgumentReachableInstructions.erase(I)) {
        numberOfUnprotectedArgumentReachableInstructions += -1;
    }
    if (m_unprotectedGlobalReachableInstructions.erase(I)) {
        numberOfUnprotectedGlobalReachableInstructions += -1;
    }
    if (m_dataDependentInstructions.erase(I)) {
        numberOfDataDependentInstructions += -1;
    }
}

void OHStats::addDataDependentInstruction(llvm::Instruction* I)
{
    if (m_dataDependentInstructions.insert(I).second) {
        numberOfDataDependentInstructions += 1;
    }
    assert(m_unprotectedArgumentReachableInstructions.find(I) == m_unprotectedArgumentReachableInstructions.end());
}

void OHStats::addNonHashableInstruction(llvm::Instruction* I)
{
    if (m_nonHashableInstructions.insert(I).second) {
        numberOfNonHashableInstructions += 1;
    }
    assert(m_unprotectedArgumentReachableInstructions.find(I) == m_unprotectedArgumentReachableInstructions.end());
}

void OHStats::addUnprotectedArgumentReachableInstruction(llvm::Instruction* I)
{
    // if I is protected by global OH this function won't get called for it.
    if (m_shortRangeProtectedInstructions.find(I) == m_shortRangeProtectedInstructions.end()) {
        if (m_unprotectedArgumentReachableInstructions.insert(I).second) {
            numberOfUnprotectedArgumentReachableInstructions += 1;
        }
    }
    assert(m_dataDependentInstructions.find(I) == m_dataDependentInstructions.end());
}

void OHStats::addUnprotectedGlobalReachableInstruction(llvm::Instruction* I)
{
    // if I is protected by global OH this function won't get called for it.
    if (m_shortRangeProtectedInstructions.find(I) == m_shortRangeProtectedInstructions.end()) {
        if (m_unprotectedGlobalReachableInstructions.insert(I).second) {
            numberOfUnprotectedGlobalReachableInstructions += 1;
        }
    }
    assert(m_dataDependentInstructions.find(I) == m_dataDependentInstructions.end());

}

void OHStats::eraseFromUnprotectedBlocks(llvm::BasicBlock* B)
{
    removeFromUnprotectedLoopBlocks(B);
    m_nonHashableBlocks.erase(B);
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
    j["numberOfSensitivePaths"] = numberOfSensitivePaths;
    j["numberOfNonHashableInstructions"] = numberOfNonHashableInstructions;
    j["numberOfUnprotectedLoopInstructions"] = numberOfUnprotectedLoopInstructions;
    j["numberOfDataDependentInstructions"] = numberOfDataDependentInstructions;
    j["numberOfUnprotectedArgumentReachableInstructions"] = numberOfUnprotectedArgumentReachableInstructions;
    j["numberOfUnprotectedGlobalReachableInstructions"] = numberOfUnprotectedGlobalReachableInstructions;
    j["numberOfUnprotectedInputDependentInstructions"] = numberOfUnprotectedInputDependentInstructions;

	std::cout << j.dump(4) << std::endl;
	std::ofstream o(filePath);
	o << std::setw(4) << j << std::endl;

    //dumpBlocks();
    dumpInstructions();
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
    //for (auto* I : m_shortRangeProtectedInstructions) {
    //    assert(m_nonHashableInstructions.find(I) == m_nonHashableInstructions.end());
    //    assert(m_dataDependentInstructions.find(I) == m_dataDependentInstructions.end());
    //    assert(m_unprotectedArgumentReachableInstructions.find(I) == m_unprotectedArgumentReachableInstructions.end());
    //    assert(m_unprotectedGlobalReachableInstructions.find(I) == m_unprotectedGlobalReachableInstructions.end());
    //}
    dump("Short range protected instructions", m_shortRangeProtectedInstructions);
    //dump("data dependent instructions", m_dataDependentInstructions);
    //dump("non hashable instructions", m_nonHashableInstructions);
    //dump("unprotected argument reachable instructions", m_unprotectedArgumentReachableInstructions);
}

}
