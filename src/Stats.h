#include "json.hpp"
#include <fstream>
#include <iostream>
#include <stdlib.h>
#include "llvm/Support/Debug.h"
#include "llvm/Support/raw_ostream.h"
using namespace llvm;
class OHStats{
	private:
		int numberOfProtectedInstructions=0;
		int numberOfProtectedArguments=0;
		int numberOfHashVariables=0;
		int numberOfHashCalls =0;
		int numberOfAssertCalls = 0;
		int numberOfProtectedGuardInstructions = 0;
		int numberOfProtectedGuardArguments = 0;
	public:
		void addNumberOfProtectedInstructions(int);
		void addNumberOfProtectedArguments(int);
		void setNumberOfHashVariables(int);
		void addNumberOfHashCalls(int);
		void addNumberOfAssertCalls(int);
		void addNumberOfProtectedGuardInstructions(int);
		void addNumberOfProtectedGuardArguments(int);
		void dumpJson(std::string fileName);
};

