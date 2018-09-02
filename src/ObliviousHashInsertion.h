#pragma once

#include "llvm/Pass.h"

#include "FunctionOHPaths.h"
#include "MemoryDefinitionData.h"
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
class Loop;
class MDNode;
}

namespace oh {

class FunctionCallSiteData;
class OHPath;

class ObliviousHashInsertionPass : public llvm::ModulePass {
private:
  using BasicBlocksSet = std::unordered_set<llvm::BasicBlock*>;
  using InstructionSet = std::unordered_set<llvm::Instruction*>;
  using ValueSet = std::unordered_set<llvm::Value*>;
  using SkipFunctionsPred = std::function<bool (llvm::Instruction* instr)>;
  using TraverseBlockPred = std::function<bool (llvm::BasicBlock* block)>;

public:
    struct short_range_path_oh
    {
        FunctionOHPaths::OHPath path;
        bool hash_invariants_only;
        bool process_det_blocks_only;
        llvm::BasicBlock* exit_block;
        llvm::BasicBlock* entry_block;
        llvm::Loop* loop;
        llvm::Function* path_assert = nullptr;
        llvm::Value* hash_variable;
        llvm::Function* extracted_path_function;
        InstructionSet path_skipped_instructions;
    };

public:
  static char ID;

  ObliviousHashInsertionPass() : llvm::ModulePass(ID) {}

  bool runOnModule(llvm::Module &M) override;
  virtual void getAnalysisUsage(llvm::AnalysisUsage &AU) const override;

private:
  // TODO: cleanup functions. Remove those not used
  void setup_guardMe_metadata();
  void setup_used_analysis_results();
  void setup_functions();
  void setup_hash_values();
  void setup_memory_defining_blocks();
  bool skip_function(llvm::Function& F);
  bool process_function(llvm::Function* F);
  bool process_function_with_short_range_oh_enabled(llvm::Function* F);
  bool process_function_with_global_oh(llvm::Function* F);
  void insert_calls_for_path_functions();
  bool process_path(llvm::Function* F,
                    FunctionOHPaths::OHPath& path,
                    const unsigned path_num);
  bool process_path(llvm::Function* F,
                    short_range_path_oh& oh_path,
                    const unsigned path_num);
  bool process_deterministic_part_of_path(llvm::Function* F,
                                          short_range_path_oh& oh_path);
  std::pair<llvm::Instruction*, llvm::Instruction*> insert_hash_variable(llvm::Function* F,
                                                                         llvm::BasicBlock* initialization_block);
  short_range_path_oh& determine_path_processing_settings(llvm::Function* F,
                                                          FunctionOHPaths::OHPath& path);
  void update_statistics_with_non_dg_function(llvm::Function* F);
  void update_statistics(const FunctionOHPaths::OHPath& path,
                         llvm::Loop* path_loop,
                         const bool is_data_dep_loop,
                         const bool is_arg_reachable_loop,
                         const bool is_glob_reachable_loop,
                         const TraverseBlockPred& traverse_block);
  InstructionSet collect_loop_invariants(llvm::Function* F,
                                         llvm::Loop* loop,
                                         const FunctionOHPaths::OHPath& path);
  void extract_path_functions();
  bool can_instrument_instruction(llvm::Function* F,
                                  llvm::Instruction* I,
                                  const SkipFunctionsPred& skipInstructionPred,
                                  InstructionSet& dataDepInstrs);
  bool process_path_block(llvm::Function* F, llvm::BasicBlock* B,
                          llvm::Value* hash_value, bool insert_assert,
                          const SkipFunctionsPred& skipInstructionPred,
                          bool& local_hash_updated,
                          int path_num,
                          InstructionSet& skipped_instructions,
                          bool hash_branch_inst);
  bool process_block(llvm::Function* F, llvm::BasicBlock* B,
                     bool insert_assert,
                     const SkipFunctionsPred& skipInstructionPred,
                     InstructionSet& skipped_instructions);
  bool isUsingGlobal(llvm::Value* value,
                     const std::unordered_set<llvm::Instruction*>& global_reachable_instr);
  llvm::Loop* get_path_loop(llvm::Function* F,
                            const FunctionOHPaths::OHPath& path);
  bool can_protect_loop_path(llvm::Function* F,
                             const FunctionOHPaths::OHPath& path,
                             llvm::Loop* path_loop,
                             bool& is_data_dep_loop,
                             bool& is_arg_reachable_loop,
                             bool& is_glob_reachable_loop);
  bool can_protect_loop_block(llvm::BasicBlock* B,
                              bool& data_dep_loop,
                              bool& arg_reachable_loop,
                              bool& global_reachable_loop);
  bool is_data_dependent_loop(llvm::Loop* loop) const;
  bool is_argument_reachable_loop(llvm::Loop* loop);
  bool is_global_reachable_loop(llvm::Loop* loop);
  void extend_loop_path(llvm::Function* F,
                        FunctionOHPaths::OHPath& path,
                        llvm::Loop* path_loop);
  void shrink_to_body_path(FunctionOHPaths::OHPath& path,
                           llvm::Loop* path_loop);
  void shrink_to_non_loop_path(FunctionOHPaths::OHPath& path,
                               llvm::Loop* path_loop);
  const InstructionSet& get_argument_reachable_instructions(llvm::Function* F);
  InstructionSet& get_global_reachable_instructions(llvm::Function* F);
  void collect_argument_reachable_instructions(llvm::Function* F);
  void collect_global_reachable_instructions(llvm::Function* F);
  bool can_insert_assertion_at_deterministic_location(llvm::Function* F,
                                                      llvm::BasicBlock* B,
                                                      llvm::LoopInfo& LI);
  bool is_value_short_range_hashed(llvm::Value* value) const;
  bool is_value_global_hashed(llvm::Value* value) const;
  bool insertHash(llvm::Instruction &I, llvm::Value *v, llvm::Value* hash_value, bool before);
  bool instrumentInst(llvm::Instruction& I, llvm::Value* hash_to_update, bool is_local_hash);
  bool instrumentBranchInst(llvm::BranchInst* branchInst,
                            llvm::Value* hash_to_update,
                            bool is_local_hash);
  template <class CallInstTy>
  bool instrumentCallInst(CallInstTy* call,
                          int& protectedArguments,
                          llvm::Value* hash_value);
  bool instrumentGetElementPtrInst(llvm::GetElementPtrInst* getElemPtr, llvm::Value* hash_value);
  bool instrumentCmpInst(llvm::CmpInst* I, llvm::Value* hash_value);
  void insertAssert(llvm::Instruction &I,
                    llvm::Value* hash_value,
                    bool short_range_assert,
                    llvm::Constant* assert_F);
  void doInsertAssert(llvm::Instruction &I,
                      llvm::Value* hash_value,
                      bool short_range_assert,
                      llvm::Constant* assert_F);
  void parse_skip_tags();
  bool hasSkipTag(llvm::Instruction& I);
  bool isInstAGuard(llvm::Instruction &I);

public:
    static const std::string oh_path_functions_callee;
    static const std::string oh_path_calls;
    static const std::string oh_hash1_name;
    static const std::string oh_hash2_name;

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
  llvm::MDNode* assert_metadata;
  std::vector<llvm::GlobalVariable *> hashPtrs;
  llvm::GlobalVariable *TempVariable;
  std::vector<unsigned> usedHashIndices;
  BasicBlocksSet m_processed_deterministic_blocks;

  std::unordered_map<llvm::Function*, MemoryDefinitionData> m_function_memory_defining_blocks;
  std::unordered_map<llvm::Function*, std::vector<short_range_path_oh>> m_function_oh_paths;
        // It's more efficient to collect skipped instructions
  std::unordered_map<llvm::Function*, InstructionSet> m_function_skipped_instructions;
  std::unordered_map<llvm::Function*, InstructionSet> m_argument_reachable_instructions;
  std::unordered_map<llvm::Function*, InstructionSet> m_global_reachable_instructions;
  std::unordered_map<llvm::BasicBlock*, InstructionSet> m_block_invariants;

  ValueSet m_globalHashedValues;
  ValueSet m_shortRangeHashedValues;
};

}
