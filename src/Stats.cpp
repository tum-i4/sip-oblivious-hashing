#include "Stats.h"
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
void OHStats::addNumberOfProtectedGuardInstructions(int value){
	this->numberOfProtectedGuardInstructions+=value;
}
void OHStats::dumpJson(std::string filePath){
	json j;
	j["numberOfProtectedInstructions"] = this->numberOfProtectedInstructions;
	j["numberOfProtectedArguments"] = this->numberOfProtectedArguments;
	j["numberOfHashVariables"] = this->numberOfHashVariables;
	j["numberOfHashCalls"] = this->numberOfHashCalls;
	j["numberOfAssertCalls"] = this->numberOfAssertCalls;
	j["numberOfProtectedGuardInstructions"] = this->numberOfProtectedGuardInstructions;
	j["numberOfProtectedGuardArguments"] = this->numberOfProtectedGuardArguments;
	std::cout << j.dump(4) << std::endl;
	std::ofstream o(filePath);
	o << std::setw(4) << j << std::endl;
}
