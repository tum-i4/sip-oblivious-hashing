#include "Stats.h"

namespace oh {

using json = nlohmann::json;

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

void OHStats::addNumberOfProtectedBlocks(int value)
{
    numberOfProtectedBlocks += value;
}

void OHStats::addNumberOfSensitiveBlocks(int value)
{
    numberOfSensitiveBlocks += value;
}

void OHStats::dumpJson(std::string filePath){
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

	j["numberOfProtectedBlocks"] = numberOfProtectedBlocks;
	j["numberOfSensitiveBlocks"] = numberOfSensitiveBlocks;
    double block_coverage = (numberOfProtectedBlocks * 100.0) /numberOfSensitiveBlocks;
	j["basicBlockCoverage"] = block_coverage;

	std::cout << j.dump(4) << std::endl;
	std::ofstream o(filePath);
	o << std::setw(4) << j << std::endl;
}

}
