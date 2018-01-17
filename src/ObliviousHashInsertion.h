#pragma once

#include "llvm/Pass.h"

#include "input-dependency/InputDependencyAnalysisPass.h"
#include "llvm/IR/IRBuilder.h"
#include <vector>
#include "Stats.h"

namespace llvm {
class CallInst;
class CmpInst;
class Constant;
class GetElementPtrInst;
class GlobalVariable;
class Instruction;
class Value;
}

namespace oh {

class ObliviousHashInsertionPass : public llvm::ModulePass {
public:
  static char ID;

  ObliviousHashInsertionPass() : llvm::ModulePass(ID) {}

  bool runOnModule(llvm::Module &M) override;
  virtual void getAnalysisUsage(llvm::AnalysisUsage &AU) const override;

private:
  void setup_functions(llvm::Module &M);
  void setup_hash_values(llvm::Module &M);
  bool insertHashBuilder(llvm::IRBuilder<> &builder, llvm::Value *v);
  bool insertHash(llvm::Instruction &I, llvm::Value *v, bool before);
  bool instrumentInst(llvm::Instruction& I);
  template <class CallInstTy>
  bool instrumentCallInst(CallInstTy* call,
                          int& protectedArguments);
  bool instrumentGetElementPtrInst(llvm::GetElementPtrInst* getElemPtr);
  bool instrumentCmpInst(llvm::CmpInst* I);
  void insertLogger(llvm::Instruction &I);
  void insertLogger(llvm::IRBuilder<> &builder, llvm::Instruction &I,
                    unsigned hashToLogIdx);
  void parse_skip_tags();
  bool isInstAGuard(llvm::Instruction &I);

private:
  OHStats stats;
  using InputDependencyAnalysisType = input_dependency::InputDependencyAnalysisPass::InputDependencyAnalysisType;
  InputDependencyAnalysisType input_dependency_info;
  bool hasTagsToSkip;
  unsigned guardMetadataKindID;
  std::vector<std::string> skipTags;
  llvm::Constant *hashFunc1;
  llvm::Constant *hashFunc2;
  llvm::Constant *logger;
  std::vector<llvm::GlobalVariable *> hashPtrs;
  std::vector<unsigned> usedHashIndices;
};
}
