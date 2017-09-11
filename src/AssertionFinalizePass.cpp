#include "AssertionFinalizePass.h"
#include "ObliviousHashInsertion.h"

#include "Utils.h"

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

char AssertionFinalizePass::ID = 0;

bool AssertionFinalizePass::runOnModule(llvm::Module &M) {
  llvm::dbgs() << "Finalize assertions\n";

  bool modified = false;
  parse_hashes();
  unique_id_generator::get().reset();
  setup_assert_function(M);
  for (auto &F : M) {
    for (auto &B : F) {
      for (auto &I : B) {
        if (auto *callInst = llvm::dyn_cast<llvm::CallInst>(&I)) {
          auto calledF = callInst->getCalledFunction();
          if (calledF && calledF->getName() == "oh_assert_dumper") {
            process_log_call(callInst);
            modified = true;
          }
        }
      }
    }
  }
  return modified;
}

void AssertionFinalizePass::parse_hashes() {
  hashes.resize(100000);
  std::ifstream hash_strm;
  hash_strm.open("hashes_dumper.log");
  if (!hash_strm.good()) {
    llvm::errs() << "ERR. hashes_dumper.log cannot be found!\n";
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

void AssertionFinalizePass::setup_assert_function(llvm::Module &M) {
  llvm::LLVMContext &Ctx = M.getContext();
  // first is the id, second argument is current hash value,
  // third is number of available hashes, then variadic number of arguments for
  // precomputed hashes
  llvm::ArrayRef<llvm::Type *> assert_params{llvm::Type::getInt32Ty(Ctx),
                                             llvm::Type::getInt64PtrTy(Ctx),
                                             llvm::Type::getInt32Ty(Ctx)};
  llvm::FunctionType *assert_type =
      llvm::FunctionType::get(llvm::Type::getVoidTy(Ctx), assert_params, true);
  assert = llvm::dyn_cast<llvm::Function>(
      M.getOrInsertFunction("oh_assert_finalize", assert_type));
}

void AssertionFinalizePass::process_log_call(llvm::CallInst *log_call) {

  llvm::dbgs() << "Processing an oh_assert_dumper call:";
  log_call->print(llvm::dbgs(), true);
  llvm::dbgs() << "\n";
  const unsigned log_id = unique_id_generator::get().next();
  const auto &precomputed_hashes = hashes[log_id];
  if (precomputed_hashes.empty()) {
    return;
  }
  // llvm::dbgs() << "log_id " << log_id << " hash values: ";

  llvm::LLVMContext &Ctx = log_call->getModule()->getContext();
  // llvm::IRBuilder<> builder(log_call);
  // builder.SetInsertPoint(log_call->getParent(), builder.GetInsertPoint());

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
  log_call->setCalledFunction(assert->getFunctionType(), assert);
  // if(log_call->getNumArgOperand()!=arg_values.size()){
  //	llvm::errs()<<"Err. The number of the operands between two patch passes
  // do not match\n";
  //      exit(1);
  //}
  if (arg_values.size() != log_call->getNumArgOperands()) {
    llvm::dbgs() << "Err. operands and args size don't match call operands:"
                 << log_call->getNumArgOperands()
                 << " arguments:" << arg_values.size() << "\n";
    llvm::dbgs() << "begin dumping call operands\n";
    for (int i = 0; i < log_call->getNumArgOperands(); ++i) {
      log_call->getArgOperand(i)->print(llvm::dbgs(), true);
      llvm::dbgs() << "\n";
    }
    llvm::dbgs() << "end dumping call operands\n";
    llvm::dbgs() << "begin dumping arg list\n";
    for (unsigned i = 0; i < arg_values.size(); i++) {
      // llvm::dbgs()<<"Value is here:"<<arg_values[i]<<"\n";
      arg_values[i]->print(llvm::dbgs(), true);
      llvm::dbgs() << "\n";
    }
    llvm::dbgs() << "end dumping call operands\n";
    exit(1);
  }
  for (unsigned i = 0; i < arg_values.size(); i++) {
    log_call->setArgOperand(i, arg_values[i]);
  }
  // builder.CreateCall(assert, arg_values);
}

static llvm::RegisterPass<AssertionFinalizePass>
    X("insert-asserts-finalize", "Inserts finalized assertions for hashes");
}
