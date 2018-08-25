#include "oblivious-hashing/AssertionInsertionPass.h"
#include "oblivious-hashing/ObliviousHashInsertion.h"

#include "oblivious-hashing/Utils.h"

#include "llvm/IR/BasicBlock.h"
#include "llvm/IR/Function.h"
#include "llvm/IR/InstrTypes.h"
#include "llvm/IR/Instructions.h"
#include "llvm/IR/LegacyPassManager.h"
#include "llvm/IR/Module.h"

#include "llvm/IR/Constants.h"
#include "llvm/IR/IRBuilder.h"
#include "llvm/Support/Casting.h"
#include "llvm/Support/Debug.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/Transforms/IPO/PassManagerBuilder.h"

#include <cassert>
#include <fstream>
#include <list>

namespace oh {

char AssertionInsertionPass::ID = 0;

bool AssertionInsertionPass::runOnModule(llvm::Module &M) {
  llvm::dbgs() << "Insert assertions\n";

  bool modified = false;
  parse_hashes();
  unique_id_generator::get().reset();
  setup_assert_function(M);
  std::list<llvm::CallInst *> log_calls;
  for (auto &F : M) {
    for (auto &B : F) {
      for (auto &I : B) {
        if (auto *callInst = llvm::dyn_cast<llvm::CallInst>(&I)) {
          auto calledF = callInst->getCalledFunction();
          if (calledF && calledF->getName() == "oh_log") {
            process_log_call(callInst);
            log_calls.push_back(callInst);
            modified = true;
          }
        }
      }
    }
  }
  while (!log_calls.empty()) {
    auto log_call = log_calls.back();
    log_calls.pop_back();
    log_call->eraseFromParent();
    modified = true;
  }
  return modified;
}

void AssertionInsertionPass::parse_hashes() {
  hashes.resize(100000);
  std::ifstream hash_strm;
  hash_strm.open("hashes.log");
  if (!hash_strm.good()) {
    llvm::errs() << "ERR. hashes.log file cannot be found!\n";
    exit(1);
  }
  std::string id_str;
  std::string hash_str;
  while (!hash_strm.eof()) {
    hash_strm >> id_str;
    hash_strm >> hash_str;
    unsigned id = std::stoi(id_str);
    uint64_t hash = std::stoull(hash_str);
    // llvm::dbgs() << id << " " << hash << "\n";
    hashes[id].insert(hash);
  }
  hash_strm.close();
}

void AssertionInsertionPass::setup_assert_function(llvm::Module &M) {
  llvm::LLVMContext &Ctx = M.getContext();
  // first is the id, second argument is current hash value,
  // third is number of available hashes, then variadic number of arguments for
  // precomputed hashes
  llvm::ArrayRef<llvm::Type *> assert_params{llvm::Type::getInt32Ty(Ctx),
                                             llvm::Type::getInt64PtrTy(Ctx),
                                             llvm::Type::getInt32Ty(Ctx)};
  llvm::FunctionType *assert_type =
      llvm::FunctionType::get(llvm::Type::getVoidTy(Ctx), assert_params, true);
  assert = M.getOrInsertFunction("oh_assert_dumper", assert_type);
}

void AssertionInsertionPass::process_log_call(llvm::CallInst *log_call) {
  const unsigned log_id = unique_id_generator::get().next();
  const auto &precomputed_hashes = hashes[log_id];
  if (precomputed_hashes.empty()) {
    return;
  }
  // llvm::dbgs() << "log_id " << log_id << " hash values: ";

  llvm::LLVMContext &Ctx = log_call->getModule()->getContext();
  llvm::IRBuilder<> builder(log_call);
  builder.SetInsertPoint(log_call->getParent(), builder.GetInsertPoint());

  std::vector<llvm::Value *> arg_values;
  llvm::Value *hash_val = log_call->getArgOperand(1);
  arg_values.push_back(log_call->getArgOperand(0));
  arg_values.push_back(hash_val);
  arg_values.push_back(llvm::ConstantInt::get(llvm::Type::getInt32Ty(Ctx),
                                              precomputed_hashes.size()));
  for (const auto &hash_value : precomputed_hashes) {
    // llvm::dbgs() << hash_value << " ";
    arg_values.push_back(
        llvm::ConstantInt::get(llvm::Type::getInt64Ty(Ctx), hash_value));
  }
  // llvm::dbgs() << "\n";
  builder.CreateCall(assert, arg_values);
}

static llvm::RegisterPass<AssertionInsertionPass>
    X("insert-asserts", "Inserts assertions for hashes");
}
