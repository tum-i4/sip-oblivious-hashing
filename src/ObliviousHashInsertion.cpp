#include "ObliviousHashInsertion.h"
#include "FunctionCallSitesInformation.h"
#include "Utils.h"

#include "llvm/Analysis/LoopInfo.h"
#include "llvm/Analysis/AliasAnalysis.h"
#include "llvm/Analysis/AssumptionCache.h"
#include "llvm/Analysis/BasicAliasAnalysis.h"
#include "llvm/Analysis/MemorySSA.h"
#include "llvm/IR/BasicBlock.h"
#include "llvm/IR/Constants.h"
#include "llvm/IR/Dominators.h"
#include "llvm/IR/Function.h"
#include "llvm/IR/InstrTypes.h"
#include "llvm/IR/Instructions.h"
#include "llvm/IR/LegacyPassManager.h"
#include "llvm/IR/Module.h"
#include "llvm/IR/Metadata.h"
#include "llvm/Support/Casting.h"
#include "llvm/Support/Debug.h"
#include "llvm/IR/Metadata.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/Transforms/IPO/PassManagerBuilder.h"
#include "llvm/Transforms/Utils/ValueMapper.h"
#include "llvm/Transforms/Utils/Cloning.h"
#include "llvm/Transforms/Utils/BasicBlockUtils.h"


#include <assert.h>
#include <boost/algorithm/string/classification.hpp> // Include boost::for is_any_of
#include <boost/algorithm/string/split.hpp>          // Include for boost::split
#include <cstdlib>
#include <ctime>
#include <fstream>
#include <iterator>
#include <sstream>
#include <string>

#include "../../self-checksumming/src/FunctionFilter.h"
#include "../../self-checksumming/src/FunctionMarker.h"

#include "input-dependency/FunctionInputDependencyResultInterface.h"

using namespace llvm;
namespace oh {

namespace {
unsigned get_random(unsigned range) { return rand() % range; }

std::vector<std::string> parse_functions_in_order(const std::string& file_name)
{
    std::vector<std::string> functions;
    std::ifstream ifs(file_name);
    std::string function;
    while (ifs >> function) {
        functions.push_back(function);
    }
    return functions;
}

bool canHashBranchInst(llvm::BranchInst* branchInst)
{
    if (!branchInst->isConditional()) {
        return false;
    }
    if (branchInst->getNumSuccessors() > 2) {
        return false;
    }
    return true;
}

bool skipInstruction(llvm::Instruction& I)
{
//    if (auto phi = llvm::dyn_cast<llvm::PHINode>(&I)) {
//        return true;
//    }
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

bool isHashableFunction(llvm::Function* called_function)
{
    if (!called_function) {
        return true;
    }
    // TODO: add more functions
    return called_function->getName() != "malloc";
}

bool shouldSkipInstruction(llvm::Instruction* instr,
                           std::unordered_set<llvm::Instruction*>& skipped_instructions)
{
    if (skipped_instructions.find(instr) != skipped_instructions.end()) {
        return true;
    }
    for (auto op = instr->op_begin(); op != instr->op_end(); ++op) {
        auto* op_instr = llvm::dyn_cast<llvm::Instruction>(&*op);
        if (!op_instr) {
            continue;
        }
        if (llvm::dyn_cast<llvm::AllocaInst>(op_instr)) {
            continue;
        }
        if (skipped_instructions.find(op_instr) != skipped_instructions.end()) {
            if (auto* storeInst = llvm::dyn_cast<llvm::StoreInst>(instr)) {
                if (op_instr == storeInst->getPointerOperand()) {
                    continue;
                }
            }
            skipped_instructions.insert(instr);
            // TODO: which section of stats add this?
            return true;
        }
    }
    return false;
}

bool isDefinedInAnotherPath(const MemoryDefinitionData::DefInfos& def_infos,
                            const FunctionOHPaths::OHPath& path,
                            std::unordered_set<llvm::Instruction*>& skipped_instructions,
                            llvm::Instruction* instr)
{
    if (def_infos.empty()) {
        return false;
    }
    for (auto& def_info : def_infos) {
        if (!FunctionOHPaths::pathContainsBlock(path, def_info.defBlock)) {
            skipped_instructions.insert(instr);
            return true;
        }
        if (skipped_instructions.find(def_info.defInstr) != skipped_instructions.end()) {
            skipped_instructions.insert(instr);
            return true;
        }
    }
    return false;
}

bool skip_short_range_instruction(llvm::Instruction* instr,
                                  const std::unordered_set<llvm::Instruction*>& argument_reachable_instr,
                                  const std::unordered_set<llvm::Instruction*>& global_reachable_instr,
                                  std::unordered_set<llvm::Instruction*>& skipped_instructions,
                                  OHStats& stats)
{
    if (argument_reachable_instr.find(instr) != argument_reachable_instr.end()) {
        stats.addUnprotectedArgumentReachableInstruction(instr);
        skipped_instructions.insert(instr);
        return true;
    } else if (global_reachable_instr.find(instr) != global_reachable_instr.end()) {
        skipped_instructions.insert(instr);
        stats.addUnprotectedGlobalReachableInstruction(instr);
        return true;
    } else if (skipped_instructions.find(instr) != skipped_instructions.end()) {
        // TODO: which section of stats add this?
        return true;
    }
    if (shouldSkipInstruction(instr, skipped_instructions)) {
        stats.addUnprotectedInstruction(instr);
        return true;
    }
    return false;
}

void get_loop_special_blocks(llvm::Loop* loop, llvm::SmallVectorImpl<llvm::BasicBlock*>& special_blocks)
{
    llvm::BasicBlock* header = loop->getHeader();
    special_blocks.push_back(header);
    loop->getLoopLatches(special_blocks);
    loop->getExitingBlocks(special_blocks);
}

bool isLoopLatch(llvm::Loop* loop, llvm::BasicBlock* B)
{
    llvm::BasicBlock* header = loop->getHeader();
    for (auto it = pred_begin(header); it != pred_end(header); ++it) {
        if (*it == B) {
            return true;
        }
    }
    return false;
}

bool is_loop_invariant(const dg::LLVMNode* node,
                       llvm::Loop* loop,
                       const FunctionOHPaths::OHPath& path,
                       const std::unordered_set<llvm::Instruction*>& invariants,
                       std::unordered_set<llvm::Value*>& processed_values)
{
    if (!node) {
        return true;
    }
    bool is_invariant = true;
    unsigned store_num = 0;
    processed_values.insert(node->getValue());
    for (auto it = node->rev_data_begin(); it != node->rev_data_end(); ++it) {
        auto* value = (*it)->getValue();
        if (!value) {
            continue;
        }
        if (processed_values.find(value) != processed_values.end()) {
            return false;
        }
        auto* instr = llvm::dyn_cast<llvm::Instruction>(value);
        if (!instr) {
            continue;
        }
        if (llvm::dyn_cast<llvm::StoreInst>(instr)) {
            if (++store_num > 1) {
                return false;
            }
        }
        if (llvm::dyn_cast<llvm::ReturnInst>(instr)) {
            return false;
        }
        if (invariants.find(instr) != invariants.end()) {
            continue;
        }
        auto* block = instr->getParent();
        if (loop->contains(block) && !FunctionOHPaths::pathContainsBlock(path, block)) {
            return false;
        }
        is_invariant &= is_loop_invariant(*it, loop, path, invariants, processed_values);
    }
    return is_invariant;
}

void dump_path(const FunctionOHPaths::OHPath& path)
{
    for (const auto& B : path) {
        llvm::dbgs() << B->getName() << "  ";
    }
    llvm::dbgs() << "\n";
}

bool isHashableValue(llvm::Value* v)
{
    if (llvm::dyn_cast<llvm::ConstantPointerNull>(v)) {
        llvm::dbgs() << "Null pointer skipped:" << *v << "\n";
        return false;
    }

    llvm::Type* valueType = v->getType();
    if (v->getType()->isPointerTy()) {
        for (auto it = v->user_begin(); it != v->user_end(); ++it) {
            if (auto* cmp = llvm::dyn_cast<llvm::CmpInst>(*it)) {
                if (llvm::dyn_cast<llvm::ConstantPointerNull>(cmp->getOperand(1))) {
                    return false;
                }
            }
        }
        valueType = v->getType()->getPointerElementType();
    }

    if (!valueType->isIntegerTy() && !valueType->isFloatingPointTy()) {
        // Currently we only handle int and float pointers
        dbgs() << "Non numeric pointers (int and float) are skipped:"
               << *v << " " << *valueType << "\n";
        return false;
    }
    return true;
}

void insertHashBuilder(llvm::IRBuilder<> &builder,
                       llvm::Value *v,
                       llvm::Value* hash_value,
                       llvm::Function* hashFunc)
{
    llvm::LLVMContext &Ctx = builder.getContext();
    llvm::Value *cast = nullptr;
    llvm::Value *load = nullptr;
    if (v->getType()->isPointerTy()) {
        load = builder.CreateLoad(v);
    } else {
        load = v;
    }

    if (load->getType()->isIntegerTy()) {
        cast = builder.CreateZExtOrBitCast(load, llvm::Type::getInt64Ty(Ctx));
    } else if (load->getType()->isFloatingPointTy()) {
        cast = builder.CreateFPToSI(load, llvm::Type::getInt64Ty(Ctx));
    } else {
        assert("false");
    }
    std::vector<llvm::Value *> arg_values;
    arg_values.push_back(hash_value);
    arg_values.push_back(cast);
    llvm::ArrayRef<llvm::Value *> args(arg_values);

    builder.CreateCall(hashFunc, args);
}

class FunctionExtractionHelper
{
public:
    using InputDepResType = input_dependency::InputDependencyAnalysisInterface::InputDepResType;
    using short_range_path_oh = ObliviousHashInsertionPass::short_range_path_oh;
    using InstructionSet = std::unordered_set<llvm::Instruction*>;

    FunctionExtractionHelper(llvm::Function* F,
                             short_range_path_oh oh_path,
                             InputDepResType inputDepRes,
                             llvm::LoopInfo& loop_info,
                             llvm::DominatorTree& domTree,
                             const InstructionSet& skipped_instrs,
                             const InstructionSet& arg_reachable_instrs,
                             const InstructionSet& global_reachable_instrs,
                             llvm::Function* assert,
                             llvm::Function* hashFunc1,
                             llvm::Function* hashFunc2,
                             const llvm::MDNode* assert_md,
                             OHStats& stats);

    void extractFunction();

    llvm::Function* getExtractedFunction()
    {
        return m_pathF;
    }

private:
    llvm::Function* createPathFunction();
    void clonePathBlocks(const FunctionOHPaths::OHPath& path);
    void clonePathInstructions();
    void createMissingInstructions();
    void createMissingOperands(llvm::Instruction* instr);
    void remapPathFunctionInstructions();
    void removeUnusedInstructions();
    void replaceUniqueAssertCall(llvm::CallInst* callInst);
    void adjustBlockTerminators();
    bool adjustTerminatorFromOriginalBlock(llvm::BasicBlock* block);
    std::pair<llvm::CallInst*, llvm::ZExtInst*> getValueHashingCall(llvm::Instruction* start_from, llvm::Value* hashedvalue);
    void eraseBranchHashingInstr(llvm::BranchInst* branchInst);
    bool hashBranch(llvm::BranchInst* originalBranchInst,
                    llvm::BasicBlock* originalBlock);
    llvm::Function* getBranchInstructionHashFunction(llvm::BranchInst* branchInst);
    bool isGlobalHashCall(llvm::CallInst* callInst);
    bool isPathShortRangeAssert(llvm::CallInst* callInst);
    bool isPathHashCall(llvm::CallInst* callInst);
    bool areCallArgumentsDataIndep(llvm::CallInst* callInst);
    bool isValidTerminator(llvm::TerminatorInst* termInst);

    static bool isSoftAssert(llvm::FunctionType* assert_type);
    static std::string getPathFunctionName(const std::string& assert_name);

private:
    llvm::Function* m_F;
    short_range_path_oh m_path;
    InputDepResType m_inputDepRes;
    llvm::LoopInfo& m_loopInfo;
    llvm::DominatorTree& m_domTree;
    const InstructionSet& m_skippedInstrs;
    const InstructionSet& m_argReachableInstrs;
    const InstructionSet& m_globalReachableInstrs;
    llvm::Function* m_assert;
    llvm::Function* m_hashFunc1;
    llvm::Function* m_hashFunc2;
    const llvm::MDNode* m_assertMd;
    OHStats& m_stats;
    llvm::Function* m_pathF;
    llvm::ValueToValueMapTy m_valueMap;
    std::unordered_map<llvm::BasicBlock*, llvm::BasicBlock*> m_block_mapping;
};

FunctionExtractionHelper::FunctionExtractionHelper(llvm::Function* F,
                                                   short_range_path_oh oh_path,
                                                   InputDepResType inputDepRes,
                                                   llvm::LoopInfo& loop_info,
                                                   llvm::DominatorTree& domTree,
                                                   const InstructionSet& skipped_instrs,
                                                   const InstructionSet& arg_reachable_instrs,
                                                   const InstructionSet& global_reachable_instrs,
                                                   llvm::Function* assert,
                                                   llvm::Function* hashFunc1,
                                                   llvm::Function* hashFunc2,
                                                   const llvm::MDNode* assert_md,
                                                   OHStats& stats)
    : m_F(F)
    , m_path(oh_path)
    , m_inputDepRes(inputDepRes)
    , m_loopInfo(loop_info)
    , m_domTree(domTree)
    , m_skippedInstrs(skipped_instrs)
    , m_argReachableInstrs(arg_reachable_instrs)
    , m_globalReachableInstrs(global_reachable_instrs)
    , m_assert(assert)
    , m_hashFunc1(hashFunc1)
    , m_hashFunc2(hashFunc2)
    , m_assertMd(assert_md)
    , m_stats(stats)
    , m_pathF(nullptr)
{
}

void FunctionExtractionHelper::extractFunction()
{
    // TODO: for debug only. Remove later
    llvm::dbgs() << "Extract path function for assertion " << m_path.path_assert->getName() << "\n";
    //llvm::dbgs() << "Path is:\n";
    //dump_path(m_path.path);

    createPathFunction();
    clonePathBlocks(m_path.path);

    // debug
    //llvm::dbgs() << "Path function structure\n";
    //m_pathF->dump();

    clonePathInstructions();
    // debug
    //llvm::dbgs() << "Path function after clonning hashed instructions\n";
    //m_pathF->dump();

    createMissingInstructions();

    adjustBlockTerminators();
    // debug
    //llvm::dbgs() << "Path function after adjusting terminating instructions\n";
    //m_pathF->dump();

    remapPathFunctionInstructions();
    removeUnusedInstructions();
    m_path.path_assert->eraseFromParent();

    //// debug
    //llvm::dbgs() << "Final path function\n";
    //m_pathF->dump();
}

llvm::Function* FunctionExtractionHelper::createPathFunction()
{
    llvm::Module* M = m_F->getParent();
    llvm::FunctionType *function_type = llvm::FunctionType::get(llvm::Type::getVoidTy(M->getContext()),
                                                                llvm::ArrayRef<llvm::Type*>(), false);
    llvm::Constant* path_F = M->getOrInsertFunction(
                                                    getPathFunctionName(m_path.path_assert->getName()),
                                                    function_type);
    m_pathF = llvm::dyn_cast<llvm::Function>(path_F);
}

void FunctionExtractionHelper::clonePathBlocks(const FunctionOHPaths::OHPath& path)
{
    for (auto& path_B : path) {
        if (m_valueMap.find(path_B) == m_valueMap.end()) {
            auto* block = llvm::BasicBlock::Create(m_pathF->getParent()->getContext(),
                                                   path_B->getName(),
                                                   m_pathF);
            m_valueMap.insert(std::make_pair(path_B, llvm::WeakTrackingVH(block)));
            m_block_mapping.insert(std::make_pair(block, path_B));
        }
    }
}

void FunctionExtractionHelper::clonePathInstructions()
{
    //llvm::dbgs() << "Skip instructions\n";
    //for (auto& inst : m_skippedInstrs) {
    //    if (inst) {
    //        llvm::dbgs() << *inst << "\n";
    //    }
    //}
    for (auto& path_B : m_path.path) {
        auto clonedB_pos = m_valueMap.find(path_B);
        auto* clonedB = llvm::dyn_cast<llvm::BasicBlock>(clonedB_pos->second);
        assert(clonedB);
        auto& instructions = clonedB->getInstList();
        for (auto& I : *path_B) {
            if (m_skippedInstrs.find(&I) != m_skippedInstrs.end()
                && !llvm::dyn_cast<llvm::AllocaInst>(&I)) {
                continue;
            }
            auto* callInst = llvm::dyn_cast<llvm::CallInst>(&I);
            if (isGlobalHashCall(callInst)
                || !isPathShortRangeAssert(callInst)
                || !isPathHashCall(callInst)) {
                continue;
            }
            // TODO: not deleting this for now, to check and make sure if we need it
            //if (auto* storeInst = llvm::dyn_cast<llvm::StoreInst>(&I)) {
            //    auto* storeTo = storeInst->getPointerOperand();
            //    if (storeTo == m_tmpGlobalVar) {
            //        auto* load = llvm::dyn_cast<llvm::LoadInst>(storeInst->getValueOperand());
            //        if (load->getOperand(0) != m_path.hash_variable) {
            //            continue;
            //        }
            //    }
            //}
            if (callInst && !areCallArgumentsDataIndep(callInst)) {
                continue;
            }
            if (llvm::dyn_cast<llvm::ReturnInst>(&I)) {
                continue;
            }
            if (callInst && callInst->getCalledFunction() == m_path.path_assert) {
                replaceUniqueAssertCall(callInst);
            }
            auto* cloned_I = I.clone();
            instructions.push_back(cloned_I);
            m_valueMap.insert(std::make_pair(&I, llvm::WeakTrackingVH(cloned_I)));
        }
    }
}

void FunctionExtractionHelper::createMissingInstructions()
{
    for (auto& B : *m_F) {
        if (!FunctionOHPaths::pathContainsBlock(m_path.path, &B)) {
            continue;
        }
        for (auto it = B.begin(); it != B.end(); ++it) {
            auto* I = &*it;
            auto I_pos = m_valueMap.find(I);
            if (I_pos == m_valueMap.end()) {
                continue;
            }
            createMissingOperands(llvm::dyn_cast<llvm::Instruction>(I_pos->second));
        }
    }
}

void FunctionExtractionHelper::createMissingOperands(llvm::Instruction* instr)
{
    if (!instr) {
        return;
    }
    bool remove_instr = false;
    llvm::LLVMContext& Ctx = instr->getParent()->getContext();
    auto* entry_block = &m_pathF->getEntryBlock();
    for (auto op = instr->op_begin(); op != instr->op_end(); ++op) {
        auto* val = llvm::dyn_cast<llvm::Value>(&*op);
        if (m_valueMap.find(val) != m_valueMap.end()) {
            continue;
        }
        if (!llvm::dyn_cast<llvm::Instruction>(val)) {
            continue;
        }
        if (auto* storeInst = llvm::dyn_cast<llvm::StoreInst>(instr)) {
            if (val == storeInst->getValueOperand()) {
                remove_instr = true;
                break;
            }
        }
        auto* type = val->getType();
        if (auto* ptrTy = llvm::dyn_cast<llvm::PointerType>(type)) {
            type = ptrTy->getElementType();
        }
        auto* var = new llvm::AllocaInst(type, 0);
        entry_block->getInstList().push_front(var);
        m_valueMap.insert(std::make_pair(val, llvm::WeakTrackingVH(var)));
    }
    if (remove_instr) {
        instr->eraseFromParent();
    }
}

void FunctionExtractionHelper::remapPathFunctionInstructions()
{
    llvm::SmallVector<llvm::BasicBlock*, 100> extracted_blocks;
    for (auto& B : *m_pathF) {
        extracted_blocks.push_back(&B);
    }
    llvm::remapInstructionsInBlocks(extracted_blocks, m_valueMap);
}

void FunctionExtractionHelper::removeUnusedInstructions()
{
    std::vector<llvm::Instruction*> instructions_to_remove;
    for (auto& B : *m_pathF) {
        for (auto it = B.rbegin(); it != B.rend(); ++it) {
            auto* I = &*it;
            if (!I->user_empty()) {
                bool has_user = false;
                for (auto user_it = I->user_begin(); user_it != I->user_end(); ++user_it) {
                    if (std::find(instructions_to_remove.begin(), instructions_to_remove.end(), *user_it) ==
                            instructions_to_remove.end()) {
                        has_user = true;
                        break;
                    }
                }
                if (has_user) {
                    continue;
                }
            }
            if (llvm::dyn_cast<llvm::StoreInst>(I)) {
                continue;
            }
            //if (llvm::dyn_cast<llvm::AllocaInst>(&I)) {
            //    continue;
            //}
            if (llvm::dyn_cast<llvm::TerminatorInst>(I)) {
                continue;
            }
            if (llvm::dyn_cast<llvm::CallInst>(I)) {
                continue;
            }
            if (llvm::dyn_cast<llvm::InvokeInst>(I)) {
                continue;
            }
            instructions_to_remove.push_back(I);
        }
    }
    auto it = instructions_to_remove.begin();
    while (it != instructions_to_remove.end()) {
        auto* I = *it;
        ++it;
        I->eraseFromParent();
    }
}

void FunctionExtractionHelper::adjustBlockTerminators()
{
    llvm::LLVMContext& Ctx = m_pathF->getParent()->getContext();
    llvm::BasicBlock* exit_block = llvm::BasicBlock::Create(Ctx, "exit", m_pathF);
    llvm::ReturnInst::Create(Ctx, exit_block);
    for (auto& block : *m_pathF) {
        auto* termInst = block.getTerminator();
        if (isValidTerminator(termInst)) {
            continue;
        }
        if (termInst) {
            termInst->eraseFromParent();
        }
        if (!adjustTerminatorFromOriginalBlock(&block)) {
            block.getInstList().push_back(llvm::BranchInst::Create(exit_block));
        }
    }
}

std::pair<llvm::CallInst*, llvm::ZExtInst*> FunctionExtractionHelper::getValueHashingCall(llvm::Instruction* start_from, llvm::Value* hashedvalue)
{
    llvm::CallInst* hashInst = nullptr;
    llvm::ZExtInst* zextInst = nullptr;
    llvm::Instruction* instr = start_from;
    while (auto* prevInstr = start_from->getParent()->getInstList().getPrevNode(*instr)) {
        if (auto* callInst = llvm::dyn_cast<llvm::CallInst>(prevInstr)) {
            auto* calledFunc = callInst->getCalledFunction();
            if (calledFunc && (calledFunc == m_hashFunc1 || calledFunc == m_hashFunc2)) {
                if (callInst->getOperand(0) == m_path.hash_variable) {
                    if (auto* hashedInstr = llvm::dyn_cast<llvm::ZExtInst>(callInst->getOperand(1))) {
                        if (hashedInstr->getOperand(0) == hashedvalue) {
                            hashInst = callInst;
                            zextInst = hashedInstr;
                            break;
                        }
                    }
                }
            }
        }
        instr = prevInstr;
    }
    return std::make_pair(hashInst, zextInst);
}

void FunctionExtractionHelper::eraseBranchHashingInstr(llvm::BranchInst* branchInst)
{
    if (!branchInst || !branchInst->isConditional()) {
        return;
    }

    std::pair<llvm::CallInst*, llvm::ZExtInst*> hash_pair = getValueHashingCall(branchInst, branchInst->getCondition());
    if (hash_pair.first) {
        hash_pair.first->eraseFromParent();
    }
    if (hash_pair.second) {
        hash_pair.second->eraseFromParent();
    }
}

bool FunctionExtractionHelper::adjustTerminatorFromOriginalBlock(llvm::BasicBlock* block)
{
    assert(!block->getTerminator());
    // terminating instruction of a block was not cloned because
    // it was either data dependent or argument reachable
    auto originalBlock_pos = m_block_mapping.find(block);
    assert(originalBlock_pos != m_block_mapping.end());
    auto* originalBlock = originalBlock_pos->second;
    auto* originalTerm = originalBlock->getTerminator();
    if (llvm::dyn_cast<llvm::UnreachableInst>(originalTerm)) {
        return false;
    }
    const bool hash_branches = (m_loopInfo.getLoopFor(block) == nullptr);
    for (unsigned i = 0; i < originalTerm->getNumSuccessors(); ++i) {
        llvm::BasicBlock* dest = originalTerm->getSuccessor(i);
        if (m_valueMap.find(dest) != m_valueMap.end()) {
            if (hash_branches) {
                if (!hashBranch(llvm::dyn_cast<llvm::BranchInst>(originalTerm), dest)) {
                    eraseBranchHashingInstr(llvm::dyn_cast<llvm::BranchInst>(originalTerm));
                } else {
                    m_stats.addShortRangeProtectedInstruction(originalTerm);
                }
            }
            block->getInstList().push_back(llvm::BranchInst::Create(dest));
            return true;
        }
    }
    eraseBranchHashingInstr(llvm::dyn_cast<llvm::BranchInst>(originalTerm));
    // none of successors is in pathF
    // take a postdominator if it's in pathF
    auto* node = m_domTree[originalBlock];
    const auto& children = node->getChildren();
    for (const auto& child : children) {
        auto* child_block = child->getBlock();
        if (m_valueMap.find(child_block) != m_valueMap.end()) {
            block->getInstList().push_back(llvm::BranchInst::Create(child_block));
            return true;
        }
    }
    // TODO: check if need this part
    llvm::SmallVector<llvm::BasicBlock*, 100> descendents;
    m_domTree.getDescendants(originalBlock, descendents);
    for (const auto& child : descendents) {
        if (child == originalBlock) {
            continue;
        }
        if (m_valueMap.find(child) != m_valueMap.end()) {
            block->getInstList().push_back(llvm::BranchInst::Create(child));
            return true;
        }
    }

    return false;
}

bool FunctionExtractionHelper::hashBranch(llvm::BranchInst* originalBranchInst,
                                          llvm::BasicBlock* originalBlock)
{
    if (!originalBranchInst) {
        return false;
    }
    if (!originalBranchInst->isConditional()) {
        return false;
    }
    // TODO: discuss how can process this case. E.g. switch branching
    if (originalBranchInst->getNumSuccessors() > 2) {
        return false;
    }
    // TODO: check if this is accurate
    // e.g. if is if.end block, can be reached both by true and false branches
    if (!originalBlock->getSinglePredecessor()) {
        return false;
    }
    llvm::Function* hashFunc = getBranchInstructionHashFunction(originalBranchInst);
    if (!hashFunc) {
        return false;
    }
    m_stats.addShortRangeProtectedInstruction(llvm::dyn_cast<llvm::Instruction>(originalBranchInst->getCondition()));
    m_stats.addShortRangeOHProtectedBlock(originalBlock);
    llvm::BasicBlock* pathBlock = llvm::dyn_cast<llvm::BasicBlock>(m_valueMap.find(originalBlock)->second);
    llvm::LLVMContext& Ctx = m_pathF->getContext();
    llvm::IRBuilder<> builder(Ctx);
    if (pathBlock->empty()) {
        builder.SetInsertPoint(pathBlock);
    } else {
        builder.SetInsertPoint(&*pathBlock->getFirstInsertionPt());
    }
    llvm::Value* cmpVal = nullptr;
    if (originalBlock == originalBranchInst->getSuccessor(0)) {
        cmpVal = llvm::ConstantInt::getTrue(Ctx);
    } else {
        cmpVal = llvm::ConstantInt::getFalse(Ctx);
    }
    if (!isHashableValue(cmpVal)) {
        return false;
    }
    insertHashBuilder(builder, cmpVal, m_path.hash_variable, hashFunc);
    return true;
}

llvm::Function* FunctionExtractionHelper::getBranchInstructionHashFunction(llvm::BranchInst* branchInst)
{
    auto hashInstr = getValueHashingCall(branchInst, branchInst->getCondition());
    if (hashInstr.first) {
        return hashInstr.first->getCalledFunction();
    }
    return nullptr;
}

void FunctionExtractionHelper::replaceUniqueAssertCall(llvm::CallInst* callInst)
{
    // assertion call looks like following
    // %0 = load i64, i64* @global
    // call void @assert(i64 %0, i64 placeholder)
    callInst->setCalledFunction(m_assert);
    llvm::LoadInst* global_load = llvm::dyn_cast<llvm::LoadInst>(callInst->getArgOperand(0));
    callInst->setArgOperand(0, global_load->getPointerOperand());
    auto pos = m_valueMap.find(global_load);
    if (pos != m_valueMap.end()) {
        if (auto* inst = llvm::dyn_cast<llvm::Instruction>(pos->second)) {
            inst->eraseFromParent();
            m_valueMap.erase(pos);
        }
    }
    global_load->eraseFromParent();
}

bool FunctionExtractionHelper::isGlobalHashCall(llvm::CallInst* callInst)
{
    if (!callInst) {
        return false;
    }
    llvm::Function* calledF = callInst->getCalledFunction();
    if (calledF == m_assert) {
        return true;
    }
    if (calledF == m_hashFunc1 || calledF == m_hashFunc2) {
        // assuming global variables are used for global oh only
        return llvm::dyn_cast<llvm::GlobalVariable>(callInst->getOperand(0));
    }
    return false;
}

bool FunctionExtractionHelper::isPathShortRangeAssert(llvm::CallInst* callInst)
{
    // if is not assertion call, return true
    if (!callInst) {
        return true;
    }
    if (!callInst->getMetadata("oh_assert")) {
        return true;
    }
    return callInst->getCalledFunction() == m_path.path_assert;
}

bool FunctionExtractionHelper::isPathHashCall(llvm::CallInst* callInst)
{
    if (!callInst) {
        return true;
    }
    if (callInst->getCalledFunction() == m_hashFunc1
            || callInst->getCalledFunction() == m_hashFunc2) {
        return callInst->getArgOperand(0) == m_path.hash_variable;
    }
    return true;
}

bool FunctionExtractionHelper::areCallArgumentsDataIndep(llvm::CallInst* callInst)
{
    if (!callInst) {
        return true;
    }
    for (int i = 0; i < callInst->getNumArgOperands(); ++i) {
        auto* operand = callInst->getArgOperand(i);
        auto* inst = llvm::dyn_cast<llvm::Instruction>(operand);
        if (!inst) {
            continue;
        }
        if (m_inputDepRes->isDataDependent(inst)
                || m_argReachableInstrs.find(inst) != m_argReachableInstrs.end()
                || m_globalReachableInstrs.find(inst) != m_globalReachableInstrs.end()
                || m_inputDepRes->isGlobalDependent(inst)) {
            return false;
        }
    }
    return true;
}

bool FunctionExtractionHelper::isValidTerminator(llvm::TerminatorInst* termInst)
{
    if (!termInst) {
        return false;
    }
    if (llvm::dyn_cast<llvm::UnreachableInst>(termInst)) {
        return false;
    }
    for (unsigned i = 0; i < termInst->getNumSuccessors(); ++i) {
        llvm::BasicBlock* tmp_dest = termInst->getSuccessor(i);
        if (m_valueMap.find(tmp_dest) == m_valueMap.end()) {
            return false;
        }
    }
    return true;
}


std::string FunctionExtractionHelper::getPathFunctionName(const std::string& assert_name)
{
    // assert name looks like assert_....
    return assert_name.substr(7);
}

std::string get_path_function_name(const std::string& base_name, unsigned path_num)
{
    std::string f_name = base_name;
    f_name += "_path_";
    f_name += std::to_string(path_num);
    return f_name;
}

llvm::FunctionType* get_path_function_type(llvm::Function* F)
{
    const auto& params = F->getFunctionType()->params();
    return llvm::FunctionType::get(llvm::Type::getVoidTy(F->getContext()), params, false);
}

llvm::Function* get_assert_function_with_name(llvm::Module* M,
                                              const std::string& f_name)
{
    llvm::LLVMContext &Ctx = M->getContext();
    llvm::ArrayRef<llvm::Type *> params;
    params = {llvm::Type::getInt64Ty(Ctx), llvm::Type::getInt64Ty(Ctx)};
    llvm::FunctionType *function_type = llvm::FunctionType::get(llvm::Type::getVoidTy(Ctx), params, false);
    return llvm::dyn_cast<llvm::Function>(M->getOrInsertFunction(f_name, function_type));
}

}

char ObliviousHashInsertionPass::ID = 0;
const std::string ObliviousHashInsertionPass::oh_path_functions_callee = "oh_path_functions";
const std::string ObliviousHashInsertionPass::oh_path_calls = "oh_path_calls";
const std::string GUARD_META_DATA = "guard";

static cl::opt<std::string>
    DumpOHStat("dump-oh-stat", cl::Hidden,
               cl::desc("File path to dump pass stat in Json format "));

static llvm::cl::opt<unsigned>
    num_hash("num-hash", llvm::cl::desc("Specify number of hash values to use"),
             llvm::cl::value_desc("num_hash"));

static llvm::cl::opt<std::string> SkipTaggedInstructions(
    "skip", llvm::cl::desc("Specify comma separated tagged instructios "
                           "(metadata) to be skipped by the OH pass"),
    llvm::cl::value_desc("skip"));

static cl::opt<bool>
    shortRangeOH("short-range-oh", cl::Hidden,
               cl::desc("Apply short range hashing"));
static cl::opt<bool>
    protectDataDepLoops("protect-data-dep-loops", cl::Hidden,
               cl::desc("Apply short range hashing on data dep loops"));

static cl::opt<std::string> CallOrderFile ("call-order", cl::Hidden,
                                           cl::desc("Call order for extracted functions"));

void ObliviousHashInsertionPass::getAnalysisUsage(llvm::AnalysisUsage &AU) const
{
    AU.setPreservesAll();
    AU.addRequired<llvm::AssumptionCacheTracker>(); // otherwise run-time error
    AU.addRequired<llvm::MemorySSAWrapperPass>();
    llvm::getAAResultsAnalysisUsage(AU);
    AU.addRequired<input_dependency::InputDependencyAnalysisPass>();
    AU.addRequired<llvm::LoopInfoWrapperPass>();
    AU.addRequired<llvm::DominatorTreeWrapperPass>();
    AU.addRequired<FunctionCallSiteInformationPass>();
    AU.addRequired<FunctionMarkerPass>();
    AU.addRequired<FunctionFilterPass>();
}

std::map<Function *, int> checkeeMap;
unsigned int getUniqueCheckeeFunctionInstructionCount(llvm::Instruction &I) {
  if (auto *metadata = I.getMetadata(GUARD_META_DATA)) {
    auto strMD = llvm::dyn_cast<llvm::MDString>(metadata->getOperand(0).get());
    auto F = I.getModule()->getFunction(strMD->getString());
    if (F == NULL) {
      errs() << "Metadata failed to find function:" << strMD->getString()
             << "\n";
    }
    // if checkee is already counted skip it
    if (checkeeMap.find(F) != checkeeMap.end()) {
      dbgs() << "Metadata already seen:" << F->getName() << "\n";
      return 0;
    } else {
      dbgs() << "Metadata seen:" << strMD->getString() << "\n";
    }

    unsigned int count = 0;
    for (BasicBlock &bb : *F) {
      count = std::distance(bb.begin(), bb.end());
    }

    // add checkee to the map
    checkeeMap[F] = 1;
    return count;
  }
  return 0;
}

bool ObliviousHashInsertionPass::isInstAGuard(llvm::Instruction &I) {
  if (auto *metadata = I.getMetadata(GUARD_META_DATA)) {
    return true;
  }
  return false;
}

bool ObliviousHashInsertionPass::is_value_short_range_hashed(llvm::Value* value) const
{
    return m_shortRangeHashedValues.find(value) != m_shortRangeHashedValues.end();
}

bool ObliviousHashInsertionPass::is_value_global_hashed(llvm::Value* value) const
{
    return m_globalHashedValues.find(value) != m_globalHashedValues.end();
}

bool ObliviousHashInsertionPass::insertHash(llvm::Instruction &I,
                                            llvm::Value *v, 
                                            llvm::Value* hash_value,
                                            bool before)
{
    //#7 requires to hash pointer operand of a StoreInst
    /*if (v->getType()->isPointerTy()) {
      return;
      }*/
    llvm::LLVMContext &Ctx = I.getModule()->getContext();
    llvm::IRBuilder<> builder(&I);
    if (before) {
        builder.SetInsertPoint(I.getParent(), builder.GetInsertPoint());
    } else {
        builder.SetInsertPoint(I.getParent(), ++builder.GetInsertPoint());
    }
    llvm::Function* hashFunc = get_random(2) ? hashFunc1 : hashFunc2;
    if (!isHashableValue(v)) {
        return false;
    }
    insertHashBuilder(builder, v, hash_value, hashFunc);
    return true;
}

void ObliviousHashInsertionPass::parse_skip_tags() {
  if (!SkipTaggedInstructions.empty()) {
    boost::split(skipTags, SkipTaggedInstructions, boost::is_any_of(","),
                 boost::token_compress_on);
    hasTagsToSkip = true;
    llvm::dbgs() << "Noted " << SkipTaggedInstructions
                 << " as instruction tag(s) to skip\n";
  } else {
    llvm::dbgs() << "No tags were supplied to be skipped! \n";
    hasTagsToSkip = false;
  }
}

bool ObliviousHashInsertionPass::hasSkipTag(llvm::Instruction& I)
{
    // skip instrumenting instructions whose tag matches the skip tag list
    if (this->hasTagsToSkip && I.hasMetadataOtherThanDebugLoc()) {
        llvm::dbgs() << "Found instruction with tags ad we have set tags\n";
        for (auto tag : skipTags) {
            llvm::dbgs() << tag << "\n";
            if (auto *metadata = I.getMetadata(tag)) {
                llvm::dbgs() << "Skipping tagged instruction: " << I << "\n";
                return true;
            }
        }
    }
    return false;
}

bool ObliviousHashInsertionPass::instrumentInst(llvm::Instruction &I,
                                                llvm::Value* hash_to_update,
                                                bool is_local_hash)
{
    bool hashInserted = false;
    if (is_local_hash) {
        if (is_value_short_range_hashed(&I)) {
            return false;
        }
    } else if (is_value_global_hashed(&I)) {
        return false;
    }
    bool isCallGuard = false;
    int protectedArguments = 0;
    if (auto* cmp = llvm::dyn_cast<llvm::CmpInst>(&I)) {
        hashInserted = instrumentCmpInst(cmp, hash_to_update);
    } else if (llvm::ReturnInst::classof(&I)) {
        auto *ret = llvm::dyn_cast<llvm::ReturnInst>(&I);
        if (auto *val = ret->getReturnValue()) {
            hashInserted = insertHash(I, val, hash_to_update, true);
        }
    } else if (llvm::LoadInst::classof(&I)) {
        auto *load = llvm::dyn_cast<llvm::LoadInst>(&I);
        if (load->getPointerOperand() != hash_to_update
                && (!is_local_hash || !llvm::dyn_cast<llvm::Argument>(load->getPointerOperand()))) {
            hashInserted = insertHash(I, load, hash_to_update, false);
        }
    } else if (llvm::StoreInst::classof(&I)) {
        auto *store = llvm::dyn_cast<llvm::StoreInst>(&I);
        llvm::Value *v = store->getPointerOperand();
        if (v != hash_to_update
                && (!is_local_hash || !llvm::dyn_cast<llvm::Argument>(store->getValueOperand()))) {
            hashInserted = insertHash(I, v, hash_to_update, false);
        }
    } else if (llvm::BinaryOperator::classof(&I)) {
        auto *bin = llvm::dyn_cast<llvm::BinaryOperator>(&I);
        if (bin->getOpcode() == llvm::Instruction::Add) {
            hashInserted = insertHash(I, bin, hash_to_update, false);
        }
    } else if (auto *call = llvm::dyn_cast<llvm::CallInst>(&I)) {
        hashInserted = instrumentCallInst(call, protectedArguments, hash_to_update);
        isCallGuard = isInstAGuard(I);
    } else if (auto* invoke = llvm::dyn_cast<llvm::InvokeInst>(&I)) {
        hashInserted = instrumentCallInst(invoke, protectedArguments, hash_to_update);
        isCallGuard = isInstAGuard(I);
    } else if (auto* getElemPtr = llvm::dyn_cast<llvm::GetElementPtrInst>(&I)) {
        hashInserted = instrumentGetElementPtrInst(getElemPtr, hash_to_update);
    } else if (!llvm::dyn_cast<llvm::PHINode>(&I)) {
        for (auto op = I.op_begin(); op != I.op_end(); ++op) {
            auto* val = llvm::dyn_cast<llvm::Value>(&*op);
            if (val && !is_value_short_range_hashed(val) && !is_value_global_hashed(val)) {
                hashInserted |= insertHash(I, val, hash_to_update, true);
            }
        }
    }

    if (hashInserted) {
        is_local_hash ? m_shortRangeHashedValues.insert(&I) : m_globalHashedValues.insert(&I);
        is_local_hash ? stats.addNumberOfShortRangeHashCalls(1) : stats.addNumberOfHashCalls(1);
        is_local_hash ? stats.addShortRangeProtectedInstruction(&I) : stats.addOhProtectedInstruction(&I);
        if (isCallGuard) {
            // When call is a guard we compute implicit OH stats
            // See #37
            unsigned int checkeeSize = getUniqueCheckeeFunctionInstructionCount(I);
            if (checkeeSize > 0) {
                dbgs()<<"Implicit protection instructions to add:"<<checkeeSize<<"\n";
            }
            is_local_hash ? stats.addSCShortRangeProtectedProtectedGuardInstr(&I, checkeeSize, protectedArguments)
                          : stats.addSCProtectedGuardInstr(&I, checkeeSize, protectedArguments);
        } else {
            is_local_hash ? stats.addNumberOfShortRangeProtectedArguments(protectedArguments) : stats.addNumberOfProtectedArguments(protectedArguments);
        }
    } else {
        stats.addNonHashableInstruction(&I);
    }

    /// END STATS

    return hashInserted;
}

bool ObliviousHashInsertionPass::instrumentBranchInst(llvm::BranchInst* branchInst,
                                                      llvm::Value* hash_to_update,
                                                      bool is_local_hash)
{
    bool hashInserted = false;
    if (is_local_hash) {
        if (is_value_short_range_hashed(branchInst)) {
            return false;
        }
    } else if (is_value_global_hashed(branchInst)) {
        return false;
    }

    if (canHashBranchInst(branchInst)) {
        hashInserted |= insertHash(*branchInst, branchInst->getCondition(), hash_to_update, true);
    }
    return hashInserted;
}


template <class CallInstTy>
bool ObliviousHashInsertionPass::instrumentCallInst(CallInstTy* call, 
                                                    int& protectedArguments,
                                                    llvm::Value* hash_value)
{
    bool hashInserted = false;
    llvm::dbgs() << "Processing call instruction..\n";
    //call->dump();
    auto called_function = call->getCalledFunction();
    if (called_function == nullptr || called_function->isIntrinsic() ||
            called_function == hashFunc1 || called_function == hashFunc2) {
        return false;
    }
    auto calledF_input_dependency_info = m_input_dependency_info->getAnalysisInfo(called_function);
    if (calledF_input_dependency_info && calledF_input_dependency_info->isExtractedFunction()) {
        m_function_skipped_instructions[call->getParent()->getParent()].insert(call);
        return false;
    }
    for (int i = 0; i < call->getNumArgOperands(); ++i) {
        auto* operand = call->getArgOperand(i);
        bool argHashed = false;
        if (auto *const_op = llvm::dyn_cast<llvm::ConstantInt>(operand)) {
            llvm::dbgs() << "***Handling a call instruction***\n";
            argHashed = insertHash(*call, const_op, hash_value, false);
            if (!argHashed) {
                errs() << "ERR. constant int argument passed to insert hash, but "
                    "failed to hash\n";
                //const_op->dump();
            } else {
                ++protectedArguments;
            }
        } else if (auto *load = llvm::dyn_cast<llvm::LoadInst>(operand)) {
            if (!m_input_dependency_info->isInputDependent(load)
                    || load->getMetadata("sc_guard")) {
                argHashed = insertHash(*load, load, hash_value, false);
                if (argHashed) {
                    ++protectedArguments;
                } else {
                    errs() << "ERR. constant int argument passed to insert hash, but "
                        "failed to hash\n";
                    //load->dump();
                }
            } else {
                llvm::dbgs() << "Can't handle input dependent load operand ";
                //load->dump();
            }
        } else {
            llvm::dbgs() << "Can't handle this operand " << *operand
                         << " of the call " << *call << "\n";
        }
        auto* operand_inst = llvm::dyn_cast<llvm::Instruction>(operand);
        if (operand_inst && m_input_dependency_info->isDataDependent(operand_inst)) {
            m_function_skipped_instructions[call->getParent()->getParent()].insert(call);
        }
        hashInserted = hashInserted || argHashed;
    }
    // TODO: comment if as one fix for memcached problem
    if (!isHashableFunction(called_function)) {
       m_function_skipped_instructions[call->getParent()->getParent()].insert(call);
    }
    auto F_input_dependency_info = m_input_dependency_info->getAnalysisInfo(call->getParent()->getParent());
    if (!F_input_dependency_info->isDataDependent(call)) {
        m_function_skipped_instructions[call->getParent()->getParent()].insert(call);
    }
    return hashInserted;
}

bool ObliviousHashInsertionPass::instrumentGetElementPtrInst(llvm::GetElementPtrInst* getElemPtr,
                                                             llvm::Value* hash_value)
{
    bool hashInserted = insertHash(*getElemPtr, getElemPtr, hash_value, false);
    // hash constant and input independent indices
    auto idx_it = getElemPtr->idx_begin();
    while (idx_it != getElemPtr->idx_end()) {
        if (auto* constant_idx = llvm::dyn_cast<llvm::Constant>(*idx_it)) {
            hashInserted |= insertHash(*getElemPtr, constant_idx, hash_value, false);
        } else if (auto* load_inst = llvm::dyn_cast<llvm::LoadInst>(*idx_it)) {
            if (!m_input_dependency_info->isInputDependent(load_inst)) {
                hashInserted |= insertHash(*getElemPtr, load_inst, hash_value, false);
            }
        }
        ++idx_it;
    }
    return hashInserted;
}

bool ObliviousHashInsertionPass::instrumentCmpInst(llvm::CmpInst* I, llvm::Value* hash_value)
{
    llvm::LLVMContext &Ctx = I->getModule()->getContext();
    llvm::IRBuilder<> builder(I);
    builder.SetInsertPoint(I->getParent(), ++builder.GetInsertPoint());

    // Insert the transformation of the cmp output into something more usable by
    // the hash function.
    llvm::Value *cmpExt =
        builder.CreateZExtOrBitCast(I, llvm::Type::getInt8Ty(Ctx));
    llvm::Value *val = builder.CreateAdd(
            builder.CreateMul(
                llvm::ConstantInt::get(llvm::Type::getInt8Ty(Ctx), 64),
                builder.CreateAdd(
                    cmpExt, llvm::ConstantInt::get(llvm::Type::getInt8Ty(Ctx), 1))),
            llvm::ConstantInt::get(llvm::Type::getInt8Ty(Ctx),
                I->getPredicate()));
    auto *AddInst = dyn_cast<Instruction>(val);
    bool hashInserted = insertHash(*AddInst, val, hash_value, false);
    if (!hashInserted) {
        errs() << "Potential ERR: insertHash failed for";
        //val->dump();
    }
    return hashInserted;
}

void ObliviousHashInsertionPass::insertAssert(llvm::Instruction &I,
                                              llvm::Value* hash_to_assert,
                                              bool short_range_assert,
                                              llvm::Constant* assert_F)
{
    // assert for cmp instruction should have been added
    if (llvm::CmpInst::classof(&I)) {
        // log the last value which contains hash for this cmp instruction
        // builder.SetInsertPoint(I.getParent(), ++builder.GetInsertPoint());
        doInsertAssert(I, hash_to_assert, short_range_assert, assert_F);
        return;
    }
    if (auto callInst = llvm::dyn_cast<llvm::CallInst>(&I)) {
        auto called_function = callInst->getCalledFunction();
        if (called_function != nullptr && !called_function->isIntrinsic() &&
                called_function != hashFunc1 && called_function != hashFunc2) {
            // always insert assert before call instructions
            doInsertAssert(I, hash_to_assert, short_range_assert, assert_F);
            return;
        }
    }
    if (short_range_assert) {
        doInsertAssert(I, hash_to_assert, true, assert_F);
    } else if (get_random(2)) {
        // insert randomly
        doInsertAssert(I, hash_to_assert, false, assert_F);
    }
}

void ObliviousHashInsertionPass::doInsertAssert(llvm::Instruction &instr,
                                                llvm::Value* hash_value,
                                                bool short_range_assert,
                                                llvm::Constant* assert_F)
{
    llvm::LLVMContext &Ctx = instr.getModule()->getContext();
    llvm::IRBuilder<> builder(&instr);
    builder.SetInsertPoint(instr.getParent(), builder.GetInsertPoint());

    ConstantInt *const_int = (ConstantInt *)ConstantInt::get(
            Type::getInt64Ty(Ctx), APInt(64, (assertCnt)* 1000000000000));
    std::vector<Value *> values; 
    llvm::LoadInst* hash_load = nullptr;
    if(short_range_assert){
        auto loaded_local_hash = builder.CreateLoad(hash_value);
        builder.CreateStore(loaded_local_hash, TempVariable);
        hash_load = builder.CreateLoad(TempVariable);
        values = {hash_load, const_int};
    } else {
        values = {hash_value, const_int};
    }
    ArrayRef<Value *> args(values);
    assertCnt++;
    // Stats add the assert call
    short_range_assert ? stats.addNumberOfShortRangeAssertCalls(1) : stats.addNumberOfAssertCalls(1);
    auto* assertCall = builder.CreateCall(assert_F, args);
    assertCall->setMetadata("oh_assert", assert_metadata);
}

void ObliviousHashInsertionPass::setup_guardMe_metadata()
{
    guardMetadataKindID = m_M->getMDKindID(GUARD_META_DATA);
    if (guardMetadataKindID > 0) {
        llvm::dbgs() << "'guard' metadata was found in the input bitcode\n";
    } else {
        llvm::dbgs() << "No 'guard' metadata was found\n";
    }
}

void ObliviousHashInsertionPass::setup_used_analysis_results()
{
    m_input_dependency_info = getAnalysis<input_dependency::InputDependencyAnalysisPass>().getInputDependencyAnalysis();
    m_function_mark_info = getAnalysis<FunctionMarkerPass>().get_functions_info();
    llvm::dbgs() << "Recieved marked functions "
                 << m_function_mark_info->get_functions().size() << "\n";
    m_function_filter_info = getAnalysis<FunctionFilterPass>().get_functions_info();
    llvm::dbgs() << "Recieved filter functions "
                 << m_function_filter_info->get_functions().size() << "\n";
    m_function_callsite_data = &getAnalysis<FunctionCallSiteInformationPass>().getAnalysisResult();
}

void ObliviousHashInsertionPass::setup_functions()
{
    // Get the function to call from our runtime library.
    llvm::LLVMContext &Ctx = m_M->getContext();
    llvm::ArrayRef<llvm::Type *> params {llvm::Type::getInt64PtrTy(Ctx),
                                         llvm::Type::getInt64Ty(Ctx)};
    llvm::FunctionType *function_type = llvm::FunctionType::get(llvm::Type::getVoidTy(Ctx), params, false);
    hashFunc1 = llvm::dyn_cast<llvm::Function>(m_M->getOrInsertFunction("hash1", function_type));
    hashFunc2 = llvm::dyn_cast<llvm::Function>(m_M->getOrInsertFunction("hash2", function_type));
    assert = llvm::dyn_cast<llvm::Function>(m_M->getOrInsertFunction("assert", function_type));
}

void ObliviousHashInsertionPass::setup_hash_values()
{
    // Insert Global hash variables
    hashPtrs.reserve(num_hash);
    stats.setNumberOfHashVariables(num_hash);

    llvm::LLVMContext &Ctx = m_M->getContext();
    for (int i = 0; i < num_hash; i++) {
        hashPtrs.push_back(new llvm::GlobalVariable(
                    *m_M, llvm::Type::getInt64Ty(Ctx), false,
                    llvm::GlobalValue::ExternalLinkage,
                    llvm::ConstantInt::get(llvm::Type::getInt64Ty(Ctx), 0)));
    }
    TempVariable = new llvm::GlobalVariable(
		         *m_M, llvm::Type::getInt64Ty(Ctx), false,
		         llvm::GlobalValue::ExternalLinkage,
		         llvm::ConstantInt::get(llvm::Type::getInt64Ty(Ctx), 0));
}

void ObliviousHashInsertionPass::setup_memory_defining_blocks()
{
    for (auto& F : *m_M) {
        if (skip_function(F)) {
            continue;
        }
        llvm::MemorySSA& ssa = getAnalysis<llvm::MemorySSAWrapperPass>(F).getMSSA();
        auto res = m_function_memory_defining_blocks.insert(std::make_pair(&F, MemoryDefinitionData(F, ssa)));
        assert(res.second);
        res.first->second.collectDefiningData();
    }
}

bool ObliviousHashInsertionPass::skip_function(llvm::Function& F)
{
    if (F.isDeclaration() || F.isIntrinsic()) {
        return true;
    }
    if (F.getMetadata("extracted")) {
        return true;
    }
    if (m_function_filter_info->get_functions().size() != 0 && !m_function_filter_info->is_function(&F)) {
        llvm::dbgs() << " Skipping function per FilterFunctionPass:" << F.getName() << "\n";
        stats.addFilteredFunction(&F);
        return true;
    }
    //stats.addNumberOfSensitiveBlocks(F.getBasicBlockList().size());
    //stats.addSensitiveInstructions(&F);
    auto F_input_dependency_info = m_input_dependency_info->getAnalysisInfo(&F);
    if (!F_input_dependency_info) {
        llvm::dbgs() << "Skipping function. No input dep info " << F.getName() << "\n";
        stats.addFunctionWithNoInputDep(&F);
        //stats.addSensitiveInstructions(&F);
        //stats.addNumberOfSensitiveBlocks(F.getBasicBlockList().size());
        return true;
    }
    if (shortRangeOH) {
        dg::LLVMDependenceGraph* F_dg = m_slicer->getDG(&F);
        if (!F_dg) {
            stats.addFunctionWithNoDg(&F);
            llvm::dbgs() << "Skip. No dependence graph for function " << F.getName() << "\n";
            //stats.addSensitiveInstructions(&F);
            //stats.addNumberOfSensitiveBlocks(F.getBasicBlockList().size());
            return true;
        }
    }
    return F_input_dependency_info->isExtractedFunction();
}

bool ObliviousHashInsertionPass::process_function(llvm::Function* F)
{
    llvm::dbgs() << " Processing function:" << F->getName() << "\n";
    stats.addNumberOfSensitiveBlocks(F->getBasicBlockList().size());
    stats.addSensitiveInstructions(F);
    if (shortRangeOH) {
        llvm::dbgs() << "Short range hashing enabled.\n";
        return process_function_with_short_range_oh_enabled(F);
    }
    return process_function_with_global_oh(F);
}

bool ObliviousHashInsertionPass::process_function_with_short_range_oh_enabled(llvm::Function* F)
{
    bool modified = false;
    llvm::DominatorTree& domTree = getAnalysis<llvm::DominatorTreeWrapperPass>(*F).getDomTree();
    llvm::LoopInfo &LI = getAnalysis<llvm::LoopInfoWrapperPass>(*F).getLoopInfo();
    FunctionOHPaths paths(F, &domTree, &LI);
    paths.constructOHPaths();

    auto F_input_dependency_info = m_input_dependency_info->getAnalysisInfo(F);
    //stats.addNumberOfSensitivePaths(paths.size());
    for (unsigned i = 0; i < paths.size(); ++i) {
        modified |= process_path(F, paths[i], i);
    }
    return modified;
}

bool ObliviousHashInsertionPass::process_function_with_global_oh(llvm::Function* F)
{
    bool modified = false;
    auto F_input_dependency_info = m_input_dependency_info->getAnalysisInfo(F);
    if (F_input_dependency_info->isInputDepFunction()) {
        llvm::dbgs() << "Skip input dependent function " << F->getName() << "\n";
        return modified;
    }
    llvm::LoopInfo &LI = getAnalysis<llvm::LoopInfoWrapperPass>(*F).getLoopInfo();
    for (auto& B : *F) {
        if (F_input_dependency_info->isInputDependentBlock(&B)) {
            stats.addUnprotectedDataDependentBlock(&B);
            continue;
        }
        llvm::dbgs() << "Process " << B.getName() << "\n";
        bool can_insert_assertions = can_insert_assertion_at_deterministic_location(F, &B, LI);
        InstructionSet skipped_instructions;
        modified |= process_block(F, &B, can_insert_assertions,
                                  [] (llvm::Instruction* instr) {return false;},
                                  skipped_instructions);
    }
    return modified;
}

void ObliviousHashInsertionPass::extract_path_functions()
{
    for (auto& function_paths : m_function_oh_paths) {
        auto F_input_dependency_info = m_input_dependency_info->getAnalysisInfo(function_paths.first);
        llvm::LoopInfo& LI = getAnalysis<llvm::LoopInfoWrapperPass>(*function_paths.first).getLoopInfo();
        llvm::DominatorTree& domTree = getAnalysis<llvm::DominatorTreeWrapperPass>(*function_paths.first).getDomTree();
        for (auto& path : function_paths.second) {
            if (!path.path_assert) {
                continue;
            }
            FunctionExtractionHelper functionExtractor(function_paths.first,
                                                       path,
                                                       F_input_dependency_info,
                                                       LI,
                                                       domTree,
                                                       m_function_skipped_instructions[function_paths.first],
                                                       get_argument_reachable_instructions(function_paths.first),
                                                       get_global_reachable_instructions(function_paths.first),
                                                       assert,
                                                       hashFunc1,
                                                       hashFunc2,
                                                       assert_metadata,
                                                       stats);
            functionExtractor.extractFunction();
            path.extracted_path_function = functionExtractor.getExtractedFunction();
        }
    }
}

void ObliviousHashInsertionPass::insert_calls_for_path_functions()
{
    // Insert function which calls oh path functions
    llvm::FunctionType *function_type = llvm::FunctionType::get(llvm::Type::getVoidTy(m_M->getContext()),
                                                                llvm::ArrayRef<llvm::Type*>(), false);
    auto* oh_path_callsF = llvm::dyn_cast<llvm::Function>(m_M->getOrInsertFunction(oh_path_calls,
                                                                                          function_type));
    llvm::LLVMContext& Ctx = oh_path_callsF->getContext();
    llvm::BasicBlock* entry_block = llvm::BasicBlock::Create(Ctx,
                                                             "entry",
                                                             oh_path_callsF);
    llvm::IRBuilder<> builder(Ctx);
    for (auto& function_paths : m_function_oh_paths) {
        for (auto& path : function_paths.second) {
            builder.SetInsertPoint(entry_block);
            builder.CreateCall(path.extracted_path_function, llvm::ArrayRef<llvm::Value*>());
        }
    }
    llvm::ReturnInst::Create(Ctx, entry_block);

    // Insert function that calls oh_path_functions_callee function
    auto* oh_path_functions_calleeF = llvm::dyn_cast<llvm::Function>(m_M->getOrInsertFunction(oh_path_functions_callee,
                                                                                              function_type));
    llvm::LLVMContext& Ctx1 = oh_path_functions_calleeF->getContext();
    llvm::BasicBlock* entry_block1 = llvm::BasicBlock::Create(Ctx1,
                                                             "entry",
                                                             oh_path_functions_calleeF);
    llvm::IRBuilder<> builder1(Ctx1);
    builder1.SetInsertPoint(entry_block1);
    builder1.CreateCall(oh_path_callsF, llvm::ArrayRef<llvm::Value*>());
    llvm::ReturnInst::Create(Ctx1, entry_block1);

    // Insert call to oh_path_calls in main
    llvm::Function* mainF = m_M->getFunction("main");
    if (!mainF) {
        llvm::dbgs() << "No main function. Can not insert calls to extracted path functions\n";
        return;
    }
    llvm::IRBuilder<> main_builder(mainF->getContext());
    main_builder.SetInsertPoint(&*mainF->getEntryBlock().getFirstInsertionPt());
    main_builder.CreateCall(oh_path_functions_calleeF, llvm::ArrayRef<llvm::Value*>());
}

llvm::Loop* ObliviousHashInsertionPass::get_path_loop(llvm::Function* F, const FunctionOHPaths::OHPath& path)
{
    llvm::LoopInfo &LI = getAnalysis<llvm::LoopInfoWrapperPass>(*F).getLoopInfo();
    for (auto& B : path) {
        if (auto* loop = LI.getLoopFor(B)) {
            return loop;
        }
    }
    return nullptr;
}

bool ObliviousHashInsertionPass::can_protect_loop_block(llvm::BasicBlock* B,
                                                        bool& data_dep_loop,
                                                        bool& arg_reachable_loop,
                                                        bool& global_reachable_loop)
{
    // the callee needs to make sure that block is a loop block
    llvm::Function* F = B->getParent();
    auto F_input_dependency_info = m_input_dependency_info->getAnalysisInfo(F);
    const auto& argument_reachable_instr = get_argument_reachable_instructions(F);
    const auto& global_reachable_instr = get_global_reachable_instructions(F);

    auto* block_terminator = B->getTerminator();
    if (F_input_dependency_info->isInputDependentBlock(B)
            || F_input_dependency_info->isDataDependent(block_terminator)) {
        data_dep_loop = true;
        return false;
    }
    if (!F_input_dependency_info->isInputDepFunction()) {
        return true;
    }
    if (argument_reachable_instr.find(block_terminator) != argument_reachable_instr.end()
            || F_input_dependency_info->isArgumentDependent(block_terminator)) {
        arg_reachable_loop = true;
        return false;
    }
    if (global_reachable_instr.find(block_terminator) != global_reachable_instr.end()
            || F_input_dependency_info->isGlobalDependent(block_terminator)) {
        global_reachable_loop = true;
        return false;
    }
    return true;
}

bool ObliviousHashInsertionPass::can_protect_loop_path(llvm::Function* F,
                                                       const FunctionOHPaths::OHPath& path,
                                                       llvm::Loop* path_loop,
                                                       bool& is_data_dep_loop,
                                                       bool& is_arg_reachable_loop,
                                                       bool& is_glob_reachable_loop)
{
    if (!path_loop) {
        return true;
    }
    bool result = true;
    auto* loop_header = path_loop->getHeader();
    llvm::LoopInfo& LI = getAnalysis<llvm::LoopInfoWrapperPass>(*F).getLoopInfo();
    if (!can_protect_loop_block(loop_header, is_data_dep_loop, is_arg_reachable_loop, is_glob_reachable_loop)) {
        result = false;
        if (is_data_dep_loop) {
            return result;
        }
    }
    for (auto& B : path) {
        auto* loop = LI.getLoopFor(B);
        if (!loop) {
            continue;
        }
        if (B == loop_header) {
            continue;
        }
        bool local_arg_dep = false;
        bool local_glob_dep = false;
        if (!can_protect_loop_block(B, is_data_dep_loop, local_arg_dep, local_glob_dep)) {
            result = false;
            if (is_data_dep_loop) {
                return result;
            }
            is_arg_reachable_loop |= local_arg_dep;
            is_glob_reachable_loop |= local_glob_dep;
        }
    }
    is_arg_reachable_loop &= !is_data_dep_loop;
    is_glob_reachable_loop &= !is_data_dep_loop;
    is_glob_reachable_loop &= !is_arg_reachable_loop;
    return result;
}

ObliviousHashInsertionPass::short_range_path_oh&
ObliviousHashInsertionPass::determine_path_processing_settings(llvm::Function* F, FunctionOHPaths::OHPath& path)
{
    short_range_path_oh oh_path;
    auto* loop = get_path_loop(F, path);
    oh_path.loop = loop;
    if (!loop) {
        oh_path.path = path;
        oh_path.process_det_blocks_only = false;
        oh_path.hash_invariants_only = false;
        oh_path.entry_block = path.front();
        oh_path.exit_block = path.back();
    } else {
        bool is_data_dep_loop = false;
        bool is_arg_reachable_loop = false;
        bool is_glob_reachable_loop = false;
        if (can_protect_loop_path(F, path, loop,
                                  is_data_dep_loop, is_arg_reachable_loop, is_glob_reachable_loop)) {
            extend_loop_path(F, path, loop);
            oh_path.path = path;
            oh_path.process_det_blocks_only = false;
            oh_path.hash_invariants_only = false;
            oh_path.entry_block = path.front();
            oh_path.exit_block = path.back();
        } else {
            assert(is_data_dep_loop || is_arg_reachable_loop || is_glob_reachable_loop);
            FunctionOHPaths::OHPath original_path = path;
            if (protectDataDepLoops) {
                update_statistics(path, loop, is_data_dep_loop,
                              is_arg_reachable_loop, is_glob_reachable_loop);
                shrink_to_body_path(path, loop);
                oh_path.path = path;
                oh_path.process_det_blocks_only = false;
                oh_path.hash_invariants_only = true;
                if (!path.empty()) {
                    oh_path.entry_block = path.front();
                    oh_path.exit_block = path.back();
                }
            } else {
                // TODO: think about this.
                // for data indep functions shrinking path may loose information,
                // while for input dep functions it makes sense to do shrinking
                //shrink_to_non_loop_path(path, loop);
                update_statistics(path, loop, is_data_dep_loop,
                              is_arg_reachable_loop, is_glob_reachable_loop);
                oh_path.path = path;
                oh_path.process_det_blocks_only = true;
                oh_path.hash_invariants_only = false;
                oh_path.entry_block = path.front();
                oh_path.exit_block = path.back();
            }
        }
    }
    auto& function_oh_paths = m_function_oh_paths[F];
    return *function_oh_paths.insert(function_oh_paths.end(), oh_path);
}

void ObliviousHashInsertionPass::update_statistics(const FunctionOHPaths::OHPath& path,
                                                   llvm::Loop* path_loop,
                                                   const bool is_data_dep_loop,
                                                   const bool is_arg_reachable_loop,
                                                   const bool is_glob_reachable_loop)
{
    for (auto& block : path) {
        if (!path_loop->contains(block)) {
            continue;
        }
        if (is_data_dep_loop) {
            stats.addUnprotectedDataDependentLoopBlock(block);
        } else if (is_arg_reachable_loop) {
            stats.addUnprotectedArgumentReachableLoopBlock(block);
        } else if (is_glob_reachable_loop) {
            stats.addUnprotectedGlobalReachableLoopBlock(block);
        }
    }
}

bool ObliviousHashInsertionPass::process_path(llvm::Function* F,
                                              FunctionOHPaths::OHPath& path,
                                              const unsigned path_num)
{
    m_shortRangeHashedValues.clear();
    bool modified = false;
    llvm::dbgs() << "Processing path: ";
    dump_path(path);
    if (path.empty()) {
        return false;
    }
    auto& oh_path = determine_path_processing_settings(F, path);
    llvm::dbgs() << "After path modifications process path";
    if (oh_path.path.empty()) {
        llvm::dbgs() << " is empty\n";
        m_function_oh_paths[F].pop_back();
        return false;
    }
    llvm::dbgs() << "\n";
    dump_path(oh_path.path);
    if (oh_path.process_det_blocks_only) {
        return process_deterministic_part_of_path(F, oh_path);
    }
    return process_path(F, oh_path, path_num);
}

bool ObliviousHashInsertionPass::process_path(llvm::Function* F,
                                              short_range_path_oh& oh_path,
                                              const unsigned path_num)
{
    bool modified = false;
    InstructionSet invariants;
    if (oh_path.hash_invariants_only) {
        llvm::dbgs() << "Hash path invariants only\n";
        if (!oh_path.loop) {
            llvm::dbgs() << "No loop information for path for which only invariants should be processed\n";
            m_function_oh_paths[F].pop_back();
            return false;
        }
        invariants = collect_loop_invariants(F, oh_path.loop, oh_path.path);
        if (invariants.empty()) {
            llvm::dbgs() << "No invariant in the path. Skip path\n";
            m_function_oh_paths[F].pop_back();
            return false;
        }
        llvm::dbgs() << "Invariants are\n";
        for (auto& I : invariants) {
            llvm::dbgs() << *I << "\n";
        }
    }
    auto hash_variable = insert_hash_variable(F, oh_path.entry_block);
    oh_path.hash_variable = hash_variable.first;
    llvm::LoopInfo &LI = getAnalysis<llvm::LoopInfoWrapperPass>(*F).getLoopInfo();
    InstructionSet path_skipped_instructions;
    // TODO TODO TODO: check why we are doing this
    if (LI.getLoopFor(oh_path.entry_block)) {
        oh_path.path.insert(oh_path.path.begin(), &F->getEntryBlock());
        for (auto& I : F->getEntryBlock()) {
            path_skipped_instructions.insert(&I);
        }
    }

    const auto& argument_reachable_instr = get_argument_reachable_instructions(F);
    auto& global_reachable_instr = get_global_reachable_instructions(F);
    auto F_input_dependency_info = m_input_dependency_info->getAnalysisInfo(F);
    InstructionSet& skipped_instructions = m_function_skipped_instructions[F];
    auto* local_hash = hash_variable.first;
    auto* local_store = hash_variable.second;
    const auto& skip_instruction_pred = [this, &local_hash, &local_store,
                                         &F_input_dependency_info,
                                         &argument_reachable_instr,
                                         &global_reachable_instr,
                                         &skipped_instructions,
                                         &path_skipped_instructions,
                                         &oh_path,
                                         &invariants]
                                        (llvm::Instruction* instr)
                                        {
                                            if (instr == local_hash || instr == local_store) {
                                                return true;
                                            }
                                            if (oh_path.hash_invariants_only) {
                                                if (invariants.find(instr) == invariants.end()) {
                                                    // TODO: add to stats
                                                    path_skipped_instructions.insert(instr);
                                                    stats.addUnprotectedLoopVariantInstruction(instr);
                                                    return true;
                                                } else {
                                                    // TODO: note that this may be incorrect, e.g. invariant which is
                                                    // using an argument or a global
                                                    return false;
                                                }
                                            }
                                            if (shouldSkipInstruction(instr, path_skipped_instructions)) {
                                                stats.addUnprotectedInstruction(instr);
                                                return true;
                                            }
                                            if (F_input_dependency_info->isGlobalDependent(instr)) {
                                                global_reachable_instr.insert(llvm::dyn_cast<llvm::Instruction>(instr));
                                                skipped_instructions.insert(llvm::dyn_cast<llvm::Instruction>(instr));
                                                stats.addUnprotectedGlobalReachableInstruction(instr);
                                                return true;
                                            }
                                            if (F_input_dependency_info->isArgumentDependent(instr)) {
                                                skipped_instructions.insert(instr);
                                                stats.addUnprotectedArgumentReachableInstruction(instr);
                                                return true;
                                            }
                                            if (isUsingGlobal(instr, global_reachable_instr)) {
                                                skipped_instructions.insert(instr);
                                                global_reachable_instr.insert(instr);
                                                if (auto* store = llvm::dyn_cast<llvm::StoreInst>(instr)) {
                                                    if (auto* storeTo = llvm::dyn_cast<llvm::Instruction>(store->getPointerOperand())) {
                                                        skipped_instructions.insert(storeTo);
                                                        global_reachable_instr.insert(storeTo);
                                                        stats.addUnprotectedGlobalReachableInstruction(storeTo);
                                                    }
                                                }
                                                stats.addUnprotectedGlobalReachableInstruction(instr);
                                                return true;
                                            }

                                            auto pos = m_function_memory_defining_blocks.find(instr->getParent()->getParent());
                                            if (pos != m_function_memory_defining_blocks.end()) {
                                                const auto& def_infos = pos->second.getDefinitionData(instr);
                                                if (isDefinedInAnotherPath(def_infos, oh_path.path, path_skipped_instructions, instr)) {
                                                    stats.addUnprotectedInstruction(instr);
                                                    return true;
                                                }
                                            }
                                            return skip_short_range_instruction(instr,
                                                    argument_reachable_instr,
                                                    global_reachable_instr,
                                                    skipped_instructions,
                                                    stats);
                                        };

    const auto& deterministic_skip_instruction_pred = [this,
                                                       &F_input_dependency_info,
                                                       &argument_reachable_instr,
                                                       &global_reachable_instr,
                                                       &skipped_instructions]
                                             (llvm::Instruction* instr) {
                                                 if (F_input_dependency_info->isGlobalDependent(instr)
                                                         || global_reachable_instr.find(instr) != global_reachable_instr.end()) {
                                                     global_reachable_instr.insert(llvm::dyn_cast<llvm::Instruction>(instr));
                                                     skipped_instructions.insert(instr);
                                                 }
                                                 if (F_input_dependency_info->isArgumentDependent(instr)
                                                         || argument_reachable_instr.find(instr) != argument_reachable_instr.end()) {
                                                     skipped_instructions.insert(instr);
                                                 }
                                                 if (isUsingGlobal(instr, global_reachable_instr)) {
                                                     global_reachable_instr.insert(llvm::dyn_cast<llvm::Instruction>(instr));
                                                     skipped_instructions.insert(instr);
                                                     if (auto* store = llvm::dyn_cast<llvm::StoreInst>(instr)) {
                                                         if (auto* storeTo = llvm::dyn_cast<llvm::Instruction>(store->getPointerOperand())) {
                                                             global_reachable_instr.insert(storeTo);
                                                             skipped_instructions.insert(storeTo);
                                                         }
                                                     }
                                                 }
                                                 return false;
                                             };
    bool has_inputdep_block = false;
    bool local_hash_updated = false;
    bool insert_assertion = false;
    for (auto& B : oh_path.path) {
        if (!F_input_dependency_info->isInputDepFunction() && !F_input_dependency_info->isInputDependentBlock(B)) {
            bool can_insert_assertions = can_insert_assertion_at_deterministic_location(F, B, LI);
            if (m_processed_deterministic_blocks.insert(B).second) {
                modified |= process_block(F, B, can_insert_assertions,
                                          deterministic_skip_instruction_pred,
                                          skipped_instructions);
            }
        } else {
            insert_assertion = (B == oh_path.exit_block);
            modified |= process_path_block(F, B, local_hash, insert_assertion,
                                           skip_instruction_pred, local_hash_updated,
                                           path_num, skipped_instructions,
                                           (oh_path.loop == nullptr) || oh_path.hash_invariants_only);
            has_inputdep_block = true;
        }
    }
    if (!modified) {
        llvm::dbgs() << "No oh has been applied in the path\n";
    }
    if (!has_inputdep_block) {
        local_store->eraseFromParent();
        local_hash->eraseFromParent();
        llvm::dbgs() << "No short range oh has been applied in the path\n";
        m_function_oh_paths[F].pop_back();
        return modified;
    }
    // means no short range assertion has been added for the path
    // TODO: have current oh path as a member variable as working with m_function_oh_paths is confusing
    if (!oh_path.path_assert) {
        local_store->eraseFromParent();
        local_hash->eraseFromParent();
        m_function_oh_paths[F].pop_back();
    }
    return modified;
}

bool ObliviousHashInsertionPass::process_deterministic_part_of_path(llvm::Function* F,
                                                                    short_range_path_oh& oh_path)
{
    llvm::dbgs() << "Processing deterministic part of the path only\n";
    bool modified = false;
    auto F_input_dependency_info = m_input_dependency_info->getAnalysisInfo(F);
    llvm::LoopInfo &LI = getAnalysis<llvm::LoopInfoWrapperPass>(*F).getLoopInfo();
    InstructionSet& skipped_instructions = m_function_skipped_instructions[F];
    const auto& argument_reachable_instr = get_argument_reachable_instructions(F);
    auto& global_reachable_instr = get_global_reachable_instructions(F);
    const auto& deterministic_skip_instruction_pred = [this,
                                                       &F_input_dependency_info,
                                                       &argument_reachable_instr,
                                                       &global_reachable_instr,
                                                       &skipped_instructions]
                                             (llvm::Instruction* instr) {
                                                 if (F_input_dependency_info->isGlobalDependent(instr)
                                                         || global_reachable_instr.find(instr) != global_reachable_instr.end()) {
                                                     global_reachable_instr.insert(llvm::dyn_cast<llvm::Instruction>(instr));
                                                     skipped_instructions.insert(instr);
                                                 }
                                                 if (F_input_dependency_info->isArgumentDependent(instr)
                                                         || argument_reachable_instr.find(instr) != argument_reachable_instr.end()) {
                                                     skipped_instructions.insert(instr);
                                                 }
                                                 if (isUsingGlobal(instr, global_reachable_instr)) {
                                                     global_reachable_instr.insert(llvm::dyn_cast<llvm::Instruction>(instr));
                                                     skipped_instructions.insert(instr);
                                                     if (auto* store = llvm::dyn_cast<llvm::StoreInst>(instr)) {
                                                         if (auto* storeTo = llvm::dyn_cast<llvm::Instruction>(store->getPointerOperand())) {
                                                             global_reachable_instr.insert(storeTo);
                                                             skipped_instructions.insert(storeTo);
                                                         }
                                                     }
                                                 }
                                                 return false;
                                             };

    for (auto& B : oh_path.path) {
        if (!F_input_dependency_info->isInputDepFunction() && !F_input_dependency_info->isInputDependentBlock(B)) {
            bool can_insert_assertions = can_insert_assertion_at_deterministic_location(F, B, LI);
            if (m_processed_deterministic_blocks.insert(B).second) {
                modified |= process_block(F, B, can_insert_assertions,
                                          deterministic_skip_instruction_pred,
                                          skipped_instructions);
            }
        } 
    }
    m_function_oh_paths[F].pop_back();
    return modified;
}

std::pair<llvm::Instruction*, llvm::Instruction*>
ObliviousHashInsertionPass::insert_hash_variable(llvm::Function* F,
                                                 llvm::BasicBlock* initialization_block)
{
    llvm::BasicBlock* function_entry_block = &F->getEntryBlock();
    llvm::LLVMContext& function_Ctx = function_entry_block->getContext();
    llvm::LLVMContext &path_Ctx = initialization_block->getContext();
    auto local_hash = new llvm::AllocaInst(llvm::Type::getInt64Ty(function_Ctx), 0, nullptr, 8, "local_hash");
    auto alloca_pos = function_entry_block->getInstList().insert(function_entry_block->begin(), local_hash);
    auto local_store = new llvm::StoreInst(llvm::ConstantInt::get(llvm::Type::getInt64Ty(path_Ctx), 0), local_hash, false, 8);
    if (function_entry_block == initialization_block) {
        initialization_block->getInstList().insertAfter(alloca_pos, local_store);
    } else {
        initialization_block->getInstList().insert(initialization_block->getFirstInsertionPt(), local_store);
    }
    return std::make_pair(local_hash, local_store);
}

ObliviousHashInsertionPass::InstructionSet
ObliviousHashInsertionPass::collect_loop_invariants(llvm::Function* F,
                                                    llvm::Loop* loop,
                                                    const FunctionOHPaths::OHPath& path)
{
    InstructionSet invariants;
    dg::LLVMDependenceGraph* F_dg = m_slicer->getDG(F);
    if (!F_dg) {
        llvm::dbgs() << "No dependence graph for function " << F->getName()
                     << "Can not identify loop invariants\n";
        return invariants;
    }

    for (auto& B : path) {
        auto block_invariants = m_block_invariants.insert(std::make_pair(B, InstructionSet()));
        if (!block_invariants.second) {
            invariants.insert(block_invariants.first->second.begin(), block_invariants.first->second.end());
            continue;
        }
        for (auto& I : *B) {
            if (invariants.find(&I) != invariants.end()) {
                continue;
            }
            
            auto I_node = F_dg->getNode(&I);
            std::unordered_set<llvm::Value*> processed_values;
            if (is_loop_invariant(I_node, loop, path, invariants, processed_values)) {
                invariants.insert(&I);
                block_invariants.first->second.insert(&I);
            }
        }
    }
    return invariants;
}

bool ObliviousHashInsertionPass::can_instrument_instruction(llvm::Function* F,
                                                            llvm::Instruction* I,
                                                            const SkipFunctionsPred& skipInstructionPred,
                                                            InstructionSet& dataDepInstrs)
{
    if (I->getMetadata("sc_guard")) {
        return true;
    }
    auto F_input_dependency_info = m_input_dependency_info->getAnalysisInfo(F);
    if (!F_input_dependency_info->isInputDependent(I)
        && !F_input_dependency_info->isInputIndependent(I)) {
        
        return false;
    }
    if (F_input_dependency_info->isDataDependent(I)) {
        stats.addDataDependentInstruction(I);
        dataDepInstrs.insert(I);
        return false;
    }
    if (hasSkipTag(*I)) {
        return false;
    }
    if (skipInstruction(*I) || skipInstructionPred(I)) {
        return false;
    }
    return true;
}

bool ObliviousHashInsertionPass::process_path_block(llvm::Function* F, llvm::BasicBlock* B,
                                               llvm::Value* hash_value, bool insert_assert,
                                               const SkipFunctionsPred& skipInstructionPred,
                                               bool& local_hash_updated,
                                               int path_num,
                                               InstructionSet& skipped_instructions,
                                               bool hash_branch_inst)
{
    bool modified = false;
    assert(hash_value);
    auto F_input_dependency_info = m_input_dependency_info->getAnalysisInfo(F);

    for (auto &I : *B) {
        if (can_instrument_instruction(F, &I, skipInstructionPred, skipped_instructions)) {
            local_hash_updated |= instrumentInst(I, hash_value, true);
            modified |= local_hash_updated;
        } else if (llvm::dyn_cast<llvm::BranchInst>(&I)) {
            if (hash_branch_inst) {
                if (instrumentBranchInst(llvm::dyn_cast<llvm::BranchInst>(&I), hash_value, true)) {
                    local_hash_updated = true;
                    skipped_instructions.insert(B->getInstList().getPrevNode(I));
                }
                modified |= local_hash_updated;
            } else {
                stats.addNonHashableInstruction(&I);
            }
        }
        if (!insert_assert || !local_hash_updated || &I != B->getTerminator()) {
            continue;
        }
        const std::string& assert_name = "assert_" + get_path_function_name(F->getName(), path_num);
        llvm::Function* path_assert = get_assert_function_with_name(F->getParent(), assert_name);
        m_function_oh_paths[F].back().path_assert = path_assert;
        insertAssert(I, hash_value, true, path_assert);
    }
    modified ? stats.addShortRangeOHProtectedBlock(B)
             : stats.addNonHashableBlock(B);
    return modified;
}

bool ObliviousHashInsertionPass::process_block(llvm::Function* F, llvm::BasicBlock* B,
                                               bool insert_assert,
                                               const SkipFunctionsPred& skipInstructionPred,
                                               InstructionSet& skipped_instructions)
{
    bool modified = false;
    auto F_input_dependency_info = m_input_dependency_info->getAnalysisInfo(F);
    for (auto &I : *B) {
        if (!can_instrument_instruction(F, &I, skipInstructionPred, skipped_instructions)) {
            continue;
        }
        unsigned index = get_random(num_hash);
        usedHashIndices.push_back(index);
        llvm::Value* hash_to_update = hashPtrs.at(index);
        m_hashUpdated |= instrumentInst(I, hash_to_update, false);
        modified |= m_hashUpdated;
        if (!insert_assert || !m_hashUpdated || usedHashIndices.empty()) {
            llvm::dbgs() << "Insert assertion skipped because there was no hash "
                            "update in between!\n";
            continue;
        }
        llvm::Value* hash_to_assert = nullptr;
        if (llvm::CmpInst::classof(&I)) {
            hash_to_assert = hashPtrs.at(usedHashIndices.back());
        } else {
            unsigned random_hash_idx =
                usedHashIndices.at(get_random(usedHashIndices.size()));
            assert(random_hash_idx < hashPtrs.size());
            hash_to_assert = hashPtrs.at(random_hash_idx);
        }
        insertAssert(I, hash_to_assert, false, assert);
        m_hashUpdated = false;
    }
    modified ? stats.addProtectedBlock(B) : stats.addNonHashableBlock(B);
    return modified;
}

bool ObliviousHashInsertionPass::isUsingGlobal(llvm::Value* value,
                                               const std::unordered_set<llvm::Instruction*>& global_reachable_instr)
{
    if (!value) {
        return false;
    }
    if (auto* global = llvm::dyn_cast<llvm::GlobalVariable>(value)) {
        if (llvm::dyn_cast<llvm::Function>(value)) {
            return false;
        }
        if (global == TempVariable || std::find(hashPtrs.begin(), hashPtrs.end(), global) != hashPtrs.end()) {
            return false;
        }
        return true;
    }
    auto* user = llvm::dyn_cast<llvm::User>(value);
    if (!user) {
        return false;
    }
    if (auto* instr = llvm::dyn_cast<llvm::Instruction>(user)) {
        if (global_reachable_instr.find(instr) != global_reachable_instr.end()) {
            return true;
        }
    }
    if (llvm::dyn_cast<llvm::AllocaInst>(value)) {
        return false;
    }
    for (auto op = user->op_begin(); op != user->op_end(); ++op) {
        if (isUsingGlobal(llvm::dyn_cast<llvm::Value>(&*op), global_reachable_instr)) {
            return true;
        }
    }
    return false;
}

bool ObliviousHashInsertionPass::is_data_dependent_loop(llvm::Loop* loop) const
{
    if (!loop) {
        return false;
    }
    llvm::BasicBlock* header = loop->getHeader();
    auto F_input_dependency_info = m_input_dependency_info->getAnalysisInfo(header->getParent());
    return  (F_input_dependency_info->isInputDependentBlock(header)
            || F_input_dependency_info->isDataDependent(header->getTerminator()));
}

bool ObliviousHashInsertionPass::is_argument_reachable_loop(llvm::Loop* loop)
{
    if (!loop) {
        return false;
    }
    llvm::Function* F = loop->getHeader()->getParent();
    auto F_input_dependency_info = m_input_dependency_info->getAnalysisInfo(F);
    llvm::SmallVector<llvm::BasicBlock*, 20> loopSpecialBlocks;
    get_loop_special_blocks(loop, loopSpecialBlocks);
    const auto& argument_reachable_instr = get_argument_reachable_instructions(F);
    for (auto& B : loopSpecialBlocks) {
        if (argument_reachable_instr.find(B->getTerminator()) != argument_reachable_instr.end()
                || F_input_dependency_info->isArgumentDependent(B->getTerminator())) {
            return true;
        }
    }
    return false;
}

bool ObliviousHashInsertionPass::is_global_reachable_loop(llvm::Loop* loop)
{
    if (!loop) {
        return false;
    }
    llvm::SmallVector<llvm::BasicBlock*, 20> loopSpecialBlocks;
    get_loop_special_blocks(loop, loopSpecialBlocks);
    llvm::Function* F = loop->getHeader()->getParent();
    const auto& global_reachable_instr = get_global_reachable_instructions(F);
    auto F_input_dependency_info = m_input_dependency_info->getAnalysisInfo(F);
    for (auto& B : loopSpecialBlocks) {
        if (global_reachable_instr.find(B->getTerminator()) != global_reachable_instr.end()
                || F_input_dependency_info->isGlobalDependent(B->getTerminator())) {
            return true;
        }
    }
    return false;
}

void ObliviousHashInsertionPass::extend_loop_path(llvm::Function* F,
                                                  FunctionOHPaths::OHPath& path,
                                                  llvm::Loop* path_loop)
{
    // path may contain a single loop only
    // get position in the path where loop blocks start
    auto it = path.begin();
    for (; it != path.end(); ++it) {
        auto* block = *it;
        if (path_loop->contains(block)) {
            break;
        }	
    }
    // this shouldn't happen
    if (it == path.end()) {
        return;
    }
    FunctionOHPaths::OHPath extended_path;
    extended_path.insert(extended_path.begin(), path.begin(), it);
    auto F_input_dependency_info = m_input_dependency_info->getAnalysisInfo(F);
    const auto& loop_blocks = path_loop->getBlocks();
    for (auto& block : loop_blocks) {
        if (!FunctionOHPaths::pathContainsBlock(extended_path, block)
                && !F_input_dependency_info->isInputDependentBlock(const_cast<llvm::BasicBlock*>(block))) {
            extended_path.push_back(block);
        }
    }
    for (; it != path.end(); ++it) {
        auto* block = *it;
        if (!FunctionOHPaths::pathContainsBlock(extended_path, block)) {
            assert(!path_loop->contains(block));
            extended_path.push_back(block);
        }
    }
    // setup exiting block for loop path
    if (path_loop->contains(extended_path.back())) {
        llvm::SmallVector<llvm::BasicBlock*, 8> exitBlocks;
        path_loop->getExitBlocks(exitBlocks);
        if (!exitBlocks.empty()) {
            extended_path.push_back(exitBlocks[0]);
        } else {
            llvm::dbgs() << "Warning: No exit block for loop. The path may be malformed\n";
        }
    }
    path = std::move(extended_path);
    llvm::dbgs() << "Extended path is \n";
    dump_path(path);
}

void ObliviousHashInsertionPass::shrink_to_body_path(FunctionOHPaths::OHPath& path,
                                                     llvm::Loop* path_loop)
{
    FunctionOHPaths::OHPath shrinked_path;
    for (auto& block : path) {
        if (!path_loop->contains(block)) {
            continue;
        }
        if (path_loop->getHeader() == block) {
            continue;
        }
        if (path_loop->isLoopLatch(block)) {
            continue;
        }
        if (path_loop->isLoopExiting(block)) {
            continue;
        }
        shrinked_path.push_back(block);
    }
    path = std::move(shrinked_path);
}

void ObliviousHashInsertionPass::shrink_to_non_loop_path(FunctionOHPaths::OHPath& path,
                                                         llvm::Loop* path_loop)
{
    FunctionOHPaths::OHPath shrinked_path;
    for (auto& block : path) {
        if (!path_loop->contains(block)) {
            shrinked_path.push_back(block);
        }
    }
    path = std::move(shrinked_path);
}

const ObliviousHashInsertionPass::InstructionSet&
ObliviousHashInsertionPass::get_argument_reachable_instructions(llvm::Function* F)
{
    auto pos = m_argument_reachable_instructions.find(F);
    if (pos == m_argument_reachable_instructions.end()) {
        collect_argument_reachable_instructions(F);
        pos = m_argument_reachable_instructions.find(F);
    }
    return pos->second;
}

ObliviousHashInsertionPass::InstructionSet&
ObliviousHashInsertionPass::get_global_reachable_instructions(llvm::Function* F)
{
    auto pos = m_global_reachable_instructions.find(F);
    if (pos == m_global_reachable_instructions.end()) {
        collect_global_reachable_instructions(F);
        pos = m_global_reachable_instructions.find(F);
    }
    return pos->second;
}

void ObliviousHashInsertionPass::collect_argument_reachable_instructions(llvm::Function* F)
{
    InstructionSet instructions;
    dg::LLVMDependenceGraph* F_dg = m_slicer->getDG(F);
    if (!F_dg) {
        llvm::dbgs() << "No dependence graph for function " << F->getName() << "\n";
        m_argument_reachable_instructions.insert(std::make_pair(F, instructions));
        return;
    }

    auto F_input_dependency_info = m_input_dependency_info->getAnalysisInfo(F);
    auto arg_it = F->arg_begin();
    while (arg_it != F->arg_end()) {
        std::list<dg::LLVMNode*> dg_nodes;
        auto arg_node = F_dg->getNode(&*arg_it);
        if (arg_node == nullptr) {
            ++arg_it;
            continue;
        }
        dg_nodes.push_back(arg_node);
        std::unordered_set<dg::LLVMNode*> processed_nodes;
        while (!dg_nodes.empty()) {
            auto node = dg_nodes.back();
            dg_nodes.pop_back();
            if (!processed_nodes.insert(node).second) {
                continue;
            }
            //llvm::dbgs() << "dg node: " << *node->getValue() << "\n";
            auto* inst = llvm::dyn_cast<llvm::Instruction>(node->getValue());
            if (inst && inst->getParent()->getParent() != F) {
                continue;
            }
            auto dep_it = node->data_begin();
            while (dep_it != node->data_end()) {
                dg_nodes.push_back(*dep_it);
                ++dep_it;
            }
            if (!inst) {
                continue;
            }
            instructions.insert(inst);
        }
        ++arg_it;
    }
    m_argument_reachable_instructions.insert(std::make_pair(F, instructions));
}

void ObliviousHashInsertionPass::collect_global_reachable_instructions(llvm::Function* F)
{
    InstructionSet instructions;
    dg::LLVMDependenceGraph* F_dg = m_slicer->getDG(F);
    if (!F_dg) {
        m_global_reachable_instructions.insert(std::make_pair(F, instructions));
        return;
    }

    auto F_input_dependency_info = m_input_dependency_info->getAnalysisInfo(F);
    auto global_it = m_M->global_begin();
    while (global_it != m_M->global_end()) {
        std::list<dg::LLVMNode*> dg_nodes;
        auto global_node = F_dg->getNode(&*global_it);
        if (global_node == nullptr) {
            ++global_it;
            continue;
        }
        dg_nodes.push_back(global_node);
        std::unordered_set<dg::LLVMNode*> processed_nodes;
        while (!dg_nodes.empty()) {
            auto node = dg_nodes.back();
            dg_nodes.pop_back();
            if (!processed_nodes.insert(node).second) {
                continue;
            }
            //llvm::dbgs() << "dg node: " << *node->getValue() << "\n";
            auto* inst = llvm::dyn_cast<llvm::Instruction>(node->getValue());
            if (inst && inst->getParent()->getParent() != F) {
                continue;
            }
            auto dep_it = node->data_begin();
            while (dep_it != node->data_end()) {
                dg_nodes.push_back(*dep_it);
                ++dep_it;
            }
            if (!inst || inst->getParent()->getParent() != F) {
                continue;
            }
            instructions.insert(inst);
        }
        ++global_it;
    }
    m_global_reachable_instructions.insert(std::make_pair(F, instructions));
}

bool ObliviousHashInsertionPass::can_insert_assertion_at_deterministic_location(
                                  llvm::Function* F,
                                  llvm::BasicBlock* B,
                                  llvm::LoopInfo& LI)
{
    // We shouldn't insert asserts when there was no hash update, see #9
    
    if (m_function_callsite_data->isFunctionCalledInLoop(F)) {
        llvm::dbgs() << "Insert assertion skipped function:" << F->getName()
                     << " because it is called from a loop!\n";
        return false;
    }

    auto loop = LI.getLoopFor(B);
    if (loop != nullptr) {
        return false;
    }
    if (!m_function_mark_info->get_functions().empty() && m_function_mark_info->is_function(F)) {
        llvm::dbgs() << "Insert assertion skipped function:" << F->getName()
                     << " because it is in the skip assert list!\n";
        return false;
    }
    // Begin #24
    // If the function has multiple callsites it should get an assert with
    // multiple correct hash values, otherwise patcher keeps the last call
    // as the correct hash. Boom! This breaks OH and signals tampering...
    // for now we insert no asserts in functions with multiple callsites
    // moving forward we should get asserts with multiple place holders
    // There is already an issue for this - #22
    int callsites = m_function_callsite_data->getNumberOfFunctionCallSites(F);
    llvm::dbgs() << "Insert assertion evaluating function:" << F->getName()
                 << " callsites detected =" << callsites << "\n";
    if (callsites > 1) {
        llvm::dbgs() << "Insert assertion skipped function:" << F->getName()
                     << " because it has more than one call site, see #24.!\n";
        return false;
    }
    // END #24
    llvm::dbgs() << "Insert assertion included function:" << F->getName()
                 << " because it is not in the skip  assert list!\n";
    return true;
}

bool ObliviousHashInsertionPass::runOnModule(llvm::Module& M)
{
    llvm::dbgs() << "Insert hash computation\n";
    assertCnt = 1;
    bool modified = false;
    srand(time(NULL));
    m_M = &M;
    if (shortRangeOH) {
        m_slicer.reset(new Slicer(m_M));
    }

    parse_skip_tags();
    setup_guardMe_metadata();
    setup_used_analysis_results();
    setup_functions();
    setup_hash_values();
    setup_memory_defining_blocks();
    auto* assert_md_str = llvm::MDString::get(M.getContext(), "oh_assert");
    assert_metadata = llvm::MDNode::get(M.getContext(), assert_md_str);

    llvm::Optional<llvm::BasicAAResult> BAR;
    llvm::Optional<llvm::AAResults> AAR;
    auto AARGetter = [&](llvm::Function* F) -> llvm::AAResults* {
        BAR.emplace(llvm::createLegacyPMBasicAAResult(*this, *F));
        AAR.emplace(llvm::createLegacyPMAAResults(*this, *F, *BAR));
        return &*AAR;
    };

    int countProcessedFuncs = 0;
    m_hashUpdated = false;
    for (auto &F : M) {
        if (skip_function(F)) {
            continue;
        }
        stats.addNumberOfSensitiveFunctions(1);
        ++countProcessedFuncs;
        m_AAR = AARGetter(&F);
        if (process_function(&F)) {
            stats.addNumberOfProtectedFunctions(1);
            modified = true;
        }
    }
    if (shortRangeOH) {
        extract_path_functions();
        insert_calls_for_path_functions();
    }

    //llvm::dbgs() << "Dump instrumented module\n";
    //M.dump();

    if (!DumpOHStat.empty()) {
        dbgs() << "OH stats is requested, dumping stat file...\n";
        stats.dumpJson(DumpOHStat);
    }
    // Make sure OH only processed filter function list
    if (countProcessedFuncs != m_function_filter_info->get_functions().size()
        && m_function_filter_info->get_functions().size() > 0) {
        llvm::errs() << "ERR. processed " << countProcessedFuncs
                     << " function, while filter count is "
                     << m_function_filter_info->get_functions().size() << "\n";
    }
    return modified;
}

static llvm::RegisterPass<ObliviousHashInsertionPass>
    X("oh-insert", "Instruments bitcode with hashing and logging functions");

static void registerPathsAnalysisPass(const llvm::PassManagerBuilder &,
                                      llvm::legacy::PassManagerBase &PM) {

  PM.add(new ObliviousHashInsertionPass());
}

static llvm::RegisterStandardPasses
    RegisterMyPass(llvm::PassManagerBuilder::EP_EarlyAsPossible,
                   registerPathsAnalysisPass);
}
