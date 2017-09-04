#pragma once

#include "llvm/Pass.h"

#include <unordered_set>

namespace llvm {
class Function;
}

namespace oh {

class AssertFunctionInformation {
public:
  using FunctionSet = std::unordered_set<llvm::Function *>;

public:
  AssertFunctionInformation() = default;
  AssertFunctionInformation(const AssertFunctionInformation &) = delete;
  AssertFunctionInformation &
  operator=(const AssertFunctionInformation &) = delete;

public:
  void collect_assert_functions(const std::string &file_name, llvm::Module &M);

  void add_assert_function(llvm::Function *F);
  bool is_assert_function(llvm::Function *F) const;
  const FunctionSet &get_assert_functions() const;

private:
  FunctionSet m_assert_functions;
}; // class SensitiveFunctionInformation

class AssertFunctionMarkPass : public llvm::ModulePass {
public:
  static char ID;

public:
  AssertFunctionMarkPass() : llvm::ModulePass(ID) {}

public:
  bool runOnModule(llvm::Module &M) override;
  virtual void getAnalysisUsage(llvm::AnalysisUsage &AU) const override;
  const AssertFunctionInformation &get_assert_functions_info() const {
    return m_assert_functions_info;
  }

private:
  AssertFunctionInformation m_assert_functions_info;
}; // class AssertFunctionMarkPass

} // namespace oh
