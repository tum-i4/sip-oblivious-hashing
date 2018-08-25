#include "oblivious-hashing/OHRunner.h"

#include "llvm/IR/BasicBlock.h"
#include "llvm/IR/Function.h"
#include "llvm/IR/InstrTypes.h"
#include "llvm/IR/Instructions.h"
#include "llvm/Support/Casting.h"
#include "llvm/Support/Debug.h"
#include "llvm/Support/raw_ostream.h"
#include "self-checksumming/FunctionFilter.h"
#include "self-checksumming/FunctionMarker.h"

#include "input-dependency/Analysis/FunctionInputDependencyResultInterface.h"

#include <boost/algorithm/string/classification.hpp> // Include boost::for is_any_of
#include <boost/algorithm/string/split.hpp>          // Include for boost::split

namespace oh {

bool OHRunner::skipFunction(llvm::Function& F) const
{
    if (F.isDeclaration() || F.isIntrinsic()) {
        return true;
    }
    if (!m_function_filter_info->get_functions().empty() && !m_function_filter_info->is_function(&F)) {
        llvm::dbgs() << " Skipping function per FilterFunctionPass:" << F.getName() << "\n";
        return true;
    }
    auto F_input_dependency_info = m_input_dependency_info->getAnalysisInfo(&F);
    if (!F_input_dependency_info) {
        llvm::dbgs() << "No input dep info for function " << F.getName() << ". Skip\n";
        return true;
    }
    // no hashes for functions called from non deterministc blocks
    if (F_input_dependency_info->isInputDepFunction() && !F_input_dependency_info->isExtractedFunction()) {
        llvm::dbgs() << "Function " << F.getName() << " is input dependent. Skip\n";
        return true;
    }
    return false;
}

bool OHRunner::skipInstruction(llvm::Instruction& I) const
{
    if (auto phi = llvm::dyn_cast<llvm::PHINode>(&I)) {
        return true;
    }
    if (auto callInst = llvm::dyn_cast<llvm::CallInst>(&I)) {
        auto calledF = callInst->getCalledFunction();
        if (calledF && (calledF->getName() == "assert"
                    || calledF->getName() == "hash1" || calledF->getName() == "hash2")) {
            return true;
        }
        // evaluate dependency of call load arguments
    }
    return false;
}

bool OHRunner::skipBasicBlock(llvm::BasicBlock& B) const
{
    auto F_input_dependency_info = m_input_dependency_info->getAnalysisInfo(B.getParent());
    if (!F_input_dependency_info || F_input_dependency_info->isInputDependentBlock(&B));
}

bool OHRunner::hasSkipTag(llvm::Instruction& I)
{
    // skip instrumenting instructions whose tag matches the skip tag list
    if (m_hasTagsToSkip && I.hasMetadataOtherThanDebugLoc()) {
        llvm::dbgs() << "Found instruction with tags ad we have set tags\n";
        for (auto tag : m_skipTags) {
            llvm::dbgs() << tag << "\n";
            if (auto *metadata = I.getMetadata(tag)) {
                llvm::dbgs() << "Skipping tagged instruction: " << I << "\n";
                return true;
            }
        }
    }
    return false;
}

void OHRunner::parse_skip_tags(const std::string& SkipTaggedInstructions)
{
  if (!SkipTaggedInstructions.empty()) {
    boost::split(m_skipTags, SkipTaggedInstructions, boost::is_any_of(","),
                 boost::token_compress_on);
    hasTagsToSkip = true;
    llvm::dbgs() << "Noted " << SkipTaggedInstructions
                 << " as instruction tag(s) to skip\n";
  } else {
    llvm::dbgs() << "No tags were supplied to be skipped! \n";
    hasTagsToSkip = false;
  }
}


} // namespace oh

