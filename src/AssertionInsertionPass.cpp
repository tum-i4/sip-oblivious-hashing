#include "AssertionInsertionPass.h"
#include "ObliviousHashInsertion.h"

#include "Utils.h"

#include "llvm/IR/BasicBlock.h"
#include "llvm/IR/Function.h"
#include "llvm/IR/Module.h"
#include "llvm/IR/Instructions.h"
#include "llvm/IR/LegacyPassManager.h"
#include "llvm/IR/InstrTypes.h"
#include "llvm/Analysis/LoopInfo.h"

#include "llvm/Transforms/IPO/PassManagerBuilder.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/Support/Debug.h"
#include "llvm/Support/Casting.h"
#include "llvm/IR/Constants.h"
#include "llvm/IR/IRBuilder.h"

#include <fstream>
#include <cassert>
#include <list>

namespace oh {

char AssertionInsertionPass::ID = 0;

bool AssertionInsertionPass::runOnModule(llvm::Module& M)
{
    llvm::dbgs() << "Insert assertions\n";

    bool modified = false;
    parse_hashes();
    unique_id_generator::get().reset();
    setup_assert_function(M);
    std::list<llvm::CallInst*> log_calls;
    for (auto& F : M) {
        for (auto& B : F) {
            for (auto& I : B) {
                if (auto* callInst = llvm::dyn_cast<llvm::CallInst>(&I)) {
                    auto calledF = callInst->getCalledFunction();
                    if (calledF && calledF->getName() == "log") {
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

void AssertionInsertionPass::parse_hashes()
{
    hashes.resize(1000);
    std::ifstream hash_strm;
    hash_strm.open("hashes.log");
    std::string id_str;
    std::string hash_str;
    while (!hash_strm.eof()) {
        hash_strm >> id_str;
        hash_strm >> hash_str;
        unsigned id = std::stoi(id_str);
        uint64_t hash = std::stoull(hash_str);
        //llvm::dbgs() << id << " " << hash << "\n";
        hashes[id] = hash;
    }
    hash_strm.close();
}

void AssertionInsertionPass::setup_assert_function(llvm::Module& M)
{
    llvm::LLVMContext& Ctx = M.getContext();
    llvm::ArrayRef<llvm::Type*> assert_params{llvm::Type::getInt64PtrTy(Ctx), llvm::Type::getInt64Ty(Ctx)};
    llvm::FunctionType* assert_type = llvm::FunctionType::get(llvm::Type::getVoidTy(Ctx), assert_params, false);
    assert = M.getOrInsertFunction("assert", assert_type);
}

void AssertionInsertionPass::process_log_call(llvm::CallInst* log_call)
{
    const unsigned log_id = unique_id_generator::get().next();
    const uint64_t precomputed_hash = hashes[log_id];
    llvm::dbgs() << "log_id " << log_id << " hash value " << precomputed_hash << "\n"; 

    llvm::LLVMContext &Ctx = log_call->getModule()->getContext();
    llvm::IRBuilder<> builder(log_call);
    builder.SetInsertPoint(log_call->getParent(), builder.GetInsertPoint());

    std::vector<llvm::Value*> arg_values;
    llvm::Value* hash_val = log_call->getArgOperand(1);
    arg_values.push_back(hash_val);
    llvm::Value* precomputed_hash_val = llvm::ConstantInt::get(llvm::Type::getInt64Ty(Ctx), precomputed_hash);
    arg_values.push_back(precomputed_hash_val);
    builder.CreateCall(assert, arg_values);
}

static llvm::RegisterPass<AssertionInsertionPass> X("insert-asserts","Inserts assertions for hashes");

}

