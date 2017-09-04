#pragma once

#include "llvm/IR/IRBuilder.h"
#include "llvm/Pass.h"

#include <unordered_set>

namespace llvm {
class CallInst;
class Constant;
class LLVMContext;
}

namespace oh {

class AssertionFinalizePass : public llvm::ModulePass {
public:
  static char ID;

  AssertionFinalizePass() : llvm::ModulePass(ID) {}

public:
  bool runOnModule(llvm::Module &M) override;

private:
  void parse_hashes();
  void setup_assert_function(llvm::Module &M);
  void process_log_call(llvm::CallInst *log_call);

private:
  using hash_value_set = std::unordered_set<uint64_t>;
  std::vector<hash_value_set> hashes;
  llvm::Function *assert;
};
}
