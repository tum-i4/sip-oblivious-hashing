#pragma once

#include "llvm/Pass.h"

#include "FunctionOHPaths.h"
#include "Stats.h"
#include "Slicer.h"
#include "input-dependency/InputDependencyAnalysisPass.h"
#include "../../self-checksumming/src/FunctionInfo.h"

#include "llvm/IR/IRBuilder.h"

#include <functional>
#include <set>
#include <vector>

namespace llvm {
class AAResults;
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
  using BasicBlocksSet = std::unordered_set<llvm::BasicBlock*>;
  using InstructionSet = std::unordered_set<llvm::Instruction*>;
  using SkipFunctionsPred = std::function<bool (llvm::Instruction* instr)>;
  void setup_guardMe_metadata();
  void setup_used_analysis_results();
  void setup_functions();
  void setup_hash_values();
  bool skip_function(llvm::Function& F) const;
  bool process_function(llvm::Function* F);
  bool process_function_with_short_range_oh_enabled(llvm::Function* F);
  bool process_function_with_global_oh(llvm::Function* F);
  void insert_calls_for_path_functions();
  bool process_path(llvm::Function* F,
                    FunctionOHPaths::OHPath& path,
                    unsigned path_num);
  void extract_path_functions();
  bool can_instrument_instruction(llvm::Function* F,
                                  llvm::Instruction* I,
                                  const SkipFunctionsPred& skipInstructionPred);
  bool process_path_block(llvm::Function* F, llvm::BasicBlock* B,
                          llvm::Value* hash_value, bool insert_assert,
                          const SkipFunctionsPred& skipInstructionPred,
                          bool& local_hash_updated,
                          int path_num, bool is_loop_path);
  bool process_block(llvm::Function* F, llvm::BasicBlock* B,
                     bool insert_assert,
                     const SkipFunctionsPred& skipInstructionPred);
  bool can_insert_short_range_assertion(llvm::Function* F,
                                        const FunctionOHPaths::OHPath& path);
  llvm::BasicBlock* get_path_exit_block(llvm::Function* F,
                                        const FunctionOHPaths::OHPath& path,
                                        bool& is_loop_path);
  const InstructionSet& get_argument_reachable_instructions(llvm::Function* F);
  void collect_argument_reachable_instructions(llvm::Function* F);
  bool can_insert_assertion_at_location(llvm::Function* F,
                                        llvm::BasicBlock* B,
                                        llvm::LoopInfo& LI);
  bool insertHashBuilder(llvm::IRBuilder<> &builder, llvm::Value *v, llvm::Value* hash_value);
  bool insertHash(llvm::Instruction &I, llvm::Value *v, llvm::Value* hash_value, bool before);
  bool instrumentInst(llvm::Instruction& I, llvm::Value* hash_to_update, bool is_local_hash);
  template <class CallInstTy>
  bool instrumentCallInst(CallInstTy* call,
                          int& protectedArguments,
                          llvm::Value* hash_value);
  bool instrumentGetElementPtrInst(llvm::GetElementPtrInst* getElemPtr, llvm::Value* hash_value);
  bool instrumentCmpInst(llvm::CmpInst* I, llvm::Value* hash_value);
  llvm::Instruction* insertAssert(llvm::Instruction &I,
                    llvm::Value* hash_value,
                    bool short_range_assert,
                    llvm::Constant* assert_F);
  llvm::Instruction*  doInsertAssert(llvm::Instruction &I,
                      llvm::Value* hash_value,
                      bool short_range_assert,
                      llvm::Constant* assert_F);
  void parse_skip_tags();
  bool hasSkipTag(llvm::Instruction& I);
  bool isInstAGuard(llvm::Instruction &I);

public:
    static const std::string oh_path_functions_callee;

private:
  llvm::Module* m_M;
  OHStats stats;
  llvm::AAResults* m_AAR;
  using InputDependencyAnalysisType = input_dependency::InputDependencyAnalysisPass::InputDependencyAnalysisType;
  InputDependencyAnalysisType m_input_dependency_info;
  FunctionInformation* m_function_mark_info;
  FunctionInformation* m_function_filter_info;
  const FunctionCallSiteData* m_function_callsite_data;
  std::unique_ptr<Slicer> m_slicer;

  bool m_hashUpdated;
  bool hasTagsToSkip;
  unsigned guardMetadataKindID;
  unsigned assertCnt;
  std::vector<std::string> skipTags;
  llvm::Function *hashFunc1;
  llvm::Function *hashFunc2;
  llvm::Function *assert;
  llvm::Function *soft_assert;
  std::vector<llvm::GlobalVariable *> hashPtrs;
  llvm::GlobalVariable *TempVariable;
  std::vector<unsigned> usedHashIndices;
  BasicBlocksSet m_processed_deterministic_blocks;
  std::unordered_map<llvm::Function*, llvm::CallInst*> m_path_function_assertion;
  // assertion function for paths for each function
  std::unordered_map<llvm::Function*, std::vector<llvm::CallInst*>> m_path_assertions;
  // path for each assert function
  std::unordered_map<llvm::Function*, FunctionOHPaths::OHPath> m_function_path;
  // argument reachable instructions
  std::unordered_map<llvm::Function*, InstructionSet> m_argument_reachable_instructions;

  InstructionSet m_globalHashedInstructions;
  InstructionSet m_shortRangeHashedInstructions;
};
}
