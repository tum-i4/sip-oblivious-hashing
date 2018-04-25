#include "json.hpp"
#include <fstream>
#include <iostream>
#include <stdlib.h>
#include "llvm/Support/Debug.h"
#include "llvm/Support/raw_ostream.h"
using namespace llvm;
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

    int numberOfProtectedBlocks = 0;
    int numberOfShortRangeProtectedBlocks = 0;
    int numberOfSensitiveBlocks = 0;

    int numberOfSensitivePaths = 0;
    int numberOfProtectedPaths = 0;
    int numberOfSensitiveFunctions = 0;
    int numberOfProtectedFunctions = 0;
    int numberOfNonHashableInstructions = 0;

    int numberOfSkippedLoopBlocks = 0;
    int numberOfSkippedArgUsingBlocks = 0;

public:
    void addNumberOfImplicitlyProtectedInstructions(int);
    void addNumberOfProtectedInstructions(int);
    void addNumberOfProtectedArguments(int);
    void setNumberOfHashVariables(int);
    void addNumberOfHashCalls(int);
    void addNumberOfAssertCalls(int);
    void addNumberOfProtectedGuardInstructions(int);
    void addNumberOfProtectedGuardArguments(int);

    void addNumberOfShortRangeImplicitlyProtectedInstructions(int);
    void addNumberOfShortRangeProtectedInstructions(int);
    void addNumberOfShortRangeProtectedArguments(int);
    void addNumberOfShortRangeHashCalls(int);
    void addNumberOfShortRangeAssertCalls(int);
    void addNumberOfShortRangeProtectedGuardInstructions(int);
    void addNumberOfShortRangeProtectedGuardArguments(int);

    void addNumberOfProtectedBlocks(int);
    void addNumberOfShortRangeProtectedBlocks(int);
    void addNumberOfSensitiveBlocks(int);

    void addNumberOfSensitiveFunctions(int);
    void addNumberOfProtectedFunctions(int);
    void addNumberOfSensitivePaths(int);
    void addNumberOfProtectedPaths(int);
    void addNumberOfNonHashableInstructions(int);

    void addNumberOfSkippedLoopBlocks(int);
    void addNumberOfSkippedArgUsingBlocks(int);

    void dumpJson(std::string fileName);
};

} // namespace oh
