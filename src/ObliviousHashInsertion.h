#pragma once

#include "llvm/IR/IRBuilder.h"
#include "llvm/IR/Instructions.h"
#include "llvm/Pass.h"
#include "Stats.h"
namespace oh {

class ObliviousHashInsertionPass : public llvm::ModulePass {
public:
  static char ID;

  ObliviousHashInsertionPass() : llvm::ModulePass(ID) {}

  bool runOnModule(llvm::Module &M) override;
  virtual void getAnalysisUsage(llvm::AnalysisUsage &AU) const override;

private:
  OHStats stats;
  void setup_functions(llvm::Module &M);
  void setup_hash_values(llvm::Module &M);
  bool insertHashBuilder(llvm::IRBuilder<> &builder, llvm::Value *v, bool isGuard);
  void insertHash(llvm::Instruction &I, llvm::Value *v, bool before);
  bool instrumentInst(llvm::Instruction &I);
  void insertLogger(llvm::Instruction &I);
  void insertLogger(llvm::IRBuilder<> &builder, llvm::Instruction &I,
                    unsigned hashToLogIdx);
  void end_logging(llvm::Instruction &I);
  void parse_skip_tags();

private:
  bool hasTagsToSkip;
  std::vector<std::string> skipTags;
  llvm::Constant *hashFunc1;
  llvm::Constant *hashFunc2;
  llvm::Constant *logger;
  std::vector<llvm::GlobalVariable *> hashPtrs;
  std::vector<unsigned> usedHashIndices;
};
}
