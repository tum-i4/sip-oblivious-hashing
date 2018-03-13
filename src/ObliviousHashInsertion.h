#pragma once

#include "llvm/Pass.h"

#include "FunctionOHPaths.h"
#include "Stats.h"
#include "input-dependency/InputDependencyAnalysisPass.h"
#include "../../self-checksumming/src/FunctionInfo.h"

#include "llvm/IR/IRBuilder.h"

#include <functional>
#include <set>
#include <vector>

namespace llvm {
class BasicBlock;
class CallInst;
class CmpInst;
class Constant;
class GetElementPtrInst;
class GlobalVariable;
class Instruction;
class Value;
class LoopInfo;
}

namespace oh {

class FunctionCallSiteData;
class OHPath;

class ObliviousHashInsertionPass : public llvm::ModulePass {
public:
  static char ID;

  ObliviousHashInsertionPass() : llvm::ModulePass(ID) {}

  bool runOnModule(llvm::Module &M) override;
  virtual void getAnalysisUsage(llvm::AnalysisUsage &AU) const override;

private:
  using SkipFunctionsPred = std::function<bool (llvm::Instruction* instr)>;
  void setup_guardMe_metadata(llvm::Module& M);
  void setup_used_analysis_results();
  void setup_functions(llvm::Module &M);
  void setup_hash_values(llvm::Module &M);
  bool skip_function(llvm::Function& F) const;
  bool process_function(llvm::Function* F);
  void insert_calls_for_path_functions(llvm::Module& M);
  bool process_path(llvm::Function* F,
                    const FunctionOHPaths::OHPath& path,
                    unsigned path_num);
  void extract_path_function(llvm::Function* F,
                             const FunctionOHPaths::OHPath& path,
                             unsigned path_num);
  bool process_block(llvm::Function* F, llvm::BasicBlock* B,
                     llvm::Value* hash_value, bool insert_assert,
                     const SkipFunctionsPred& skipInstruction);
  bool can_process_path(llvm::Function* F, const FunctionOHPaths::OHPath& path);
  bool can_insert_assertion_at_location(llvm::Function* F,
                                        llvm::BasicBlock* B,
                                        llvm::LoopInfo& LI);
  bool insertHashBuilder(llvm::IRBuilder<> &builder, llvm::Value *v, llvm::Value* hash_value);
  bool insertHash(llvm::Instruction &I, llvm::Value *v, llvm::Value* hash_value, bool before);
  bool instrumentInst(llvm::Instruction& I, llvm::Value* hash_value);
  template <class CallInstTy>
  bool instrumentCallInst(CallInstTy* call,
                          int& protectedArguments,
                          llvm::Value* hash_value);
  bool instrumentGetElementPtrInst(llvm::GetElementPtrInst* getElemPtr, llvm::Value* hash_value);
  bool instrumentCmpInst(llvm::CmpInst* I, llvm::Value* hash_value);
  void insertAssert(llvm::Instruction &I, llvm::Value* hash_value);
  void insertAssert(llvm::IRBuilder<> &builder,
                    llvm::Instruction &I,
                    llvm::Value* hash_value,
                    bool short_range_assert);
  void parse_skip_tags();
  bool hasSkipTag(llvm::Instruction& I);
  bool isInstAGuard(llvm::Instruction &I);

private:
  OHStats stats;
  using InputDependencyAnalysisType = input_dependency::InputDependencyAnalysisPass::InputDependencyAnalysisType;
  InputDependencyAnalysisType m_input_dependency_info;
  FunctionInformation* m_function_mark_info;
  FunctionInformation* m_function_filter_info;
  const FunctionCallSiteData* m_function_callsite_data;

  bool m_hashUpdated;
  bool hasTagsToSkip;
  unsigned guardMetadataKindID;
  unsigned assertCnt;
  std::vector<std::string> skipTags;
  llvm::Constant *hashFunc1;
  llvm::Constant *hashFunc2;
  llvm::Constant *assert;
  std::vector<llvm::GlobalVariable *> hashPtrs;
  std::vector<unsigned> usedHashIndices;
  std::unordered_set<llvm::BasicBlock*> m_processed_deterministic_blocks;
  std::unordered_map<llvm::Function*, std::vector<llvm::Function*>> m_path_functions;
};
}
