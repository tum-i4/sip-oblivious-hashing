#include "llvm/IR/BasicBlock.h"
#include "llvm/IR/Function.h"
#include "llvm/IR/InstrTypes.h"
#include "llvm/IR/Instructions.h"
#include "llvm/IR/LegacyPassManager.h"
#include "llvm/IR/Metadata.h"
#include "llvm/IR/Module.h"

#include "llvm/IR/Constants.h"
#include "llvm/IR/IRBuilder.h"
#include "llvm/Support/Casting.h"
#include "llvm/Support/Debug.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/Transforms/IPO/PassManagerBuilder.h"

class unique_id_generator {
public:
  unique_id_generator() : id(0) {}

  unsigned next() { return id++; }

private:
  unsigned id;
};

class TestMetadataSetter : public llvm::FunctionPass {
public:
  static char ID;

  TestMetadataSetter() : llvm::FunctionPass(ID) {}

public:
  bool runOnFunction(llvm::Function &F) {
    unique_id_generator id_gen;
    llvm::LLVMContext &Ctx = F.getContext();
    for (auto &B : F) {
      for (auto &I : B) {
        if (auto *callInst = llvm::dyn_cast<llvm::CallInst>(&I)) {
          llvm::Constant *const_id = llvm::ConstantInt::get(
              llvm::Type::getInt64Ty(Ctx), id_gen.next());
          llvm::ConstantAsMetadata *const_metadata =
              llvm::ConstantAsMetadata::get(const_id);
          llvm::MDTuple *tuple = llvm::MDNode::get(Ctx, {const_metadata});
          callInst->setMetadata("instr_id", tuple);
        }
      }
    }
    return false;
  }
};

char TestMetadataSetter::ID = 0;

static llvm::RegisterPass<TestMetadataSetter>
    X("test-metadata", "Reports input dependent instructions in bitcode");

class TestMetadataGetter : public llvm::FunctionPass {
public:
  static char ID;

  TestMetadataGetter() : llvm::FunctionPass(ID) {}

public:
  void getAnalysisUsage(llvm::AnalysisUsage &AU) const override {
    AU.setPreservesAll();
    AU.addRequired<TestMetadataSetter>();
  }

  bool runOnFunction(llvm::Function &F) {
    llvm::LLVMContext &Ctx = F.getContext();
    llvm::IRBuilder<> builder(Ctx);
    llvm::ArrayRef<llvm::Type *> params{llvm::Type::getInt64Ty(Ctx)};
    llvm::FunctionType *function_type =
        llvm::FunctionType::get(llvm::Type::getVoidTy(Ctx), params, false);
    auto logger = F.getParent()->getOrInsertFunction("log", function_type);

    for (auto &B : F) {
      for (auto &I : B) {
        if (auto *callInst = llvm::dyn_cast<llvm::CallInst>(&I)) {
          const auto &debug_loc = callInst->getDebugLoc();
          if (debug_loc.get() == nullptr) {
            llvm::dbgs() << "No debug info for instruction " << *callInst
                         << "\n";
            continue;
          }
          auto val = llvm::ConstantInt::get(llvm::Type::getInt64Ty(Ctx),
                                            debug_loc.getLine());
          llvm::ArrayRef<llvm::Value *> args(val);
          builder.SetInsertPoint(callInst);
          builder.CreateCall(logger, args);
        }
      }
    }
    return false;
  }
};

char TestMetadataGetter::ID = 0;
static llvm::RegisterPass<TestMetadataGetter>
    Y("test-metadata-get", "Reports input dependent instructions in bitcode");
