#include "ObliviousHashInsertion.h"
#include "FunctionCallSitesInformation.h"
#include "Utils.h"

#include "llvm/Analysis/LoopInfo.h"
#include "llvm/IR/BasicBlock.h"
#include "llvm/IR/Constants.h"
#include "llvm/IR/Function.h"
#include "llvm/IR/InstrTypes.h"
#include "llvm/IR/Instructions.h"
#include "llvm/IR/LegacyPassManager.h"
#include "llvm/IR/Module.h"
#include "llvm/Support/Casting.h"
#include "llvm/Support/Debug.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/Transforms/IPO/PassManagerBuilder.h"

#include <assert.h>
#include <boost/algorithm/string/classification.hpp> // Include boost::for is_any_of
#include <boost/algorithm/string/split.hpp>          // Include for boost::split
#include <cstdlib>
#include <ctime>
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
}

char ObliviousHashInsertionPass::ID = 0;
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

void ObliviousHashInsertionPass::getAnalysisUsage(
    llvm::AnalysisUsage &AU) const {
  AU.setPreservesAll();
  AU.addRequired<input_dependency::InputDependencyAnalysisPass>();
  AU.addRequired<llvm::LoopInfoWrapperPass>();
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
bool ObliviousHashInsertionPass::insertHash(llvm::Instruction &I,
                                            llvm::Value *v, bool before) {
  //#7 requires to hash pointer operand of a StoreInst
  /*if (v->getType()->isPointerTy()) {
    return;
  }*/
  llvm::LLVMContext &Ctx = I.getModule()->getContext();
  llvm::IRBuilder<> builder(&I);
  if (before)
    builder.SetInsertPoint(I.getParent(), builder.GetInsertPoint());
  else
    builder.SetInsertPoint(I.getParent(), ++builder.GetInsertPoint());
  return insertHashBuilder(builder, v);
}

bool ObliviousHashInsertionPass::insertHashBuilder(llvm::IRBuilder<> &builder,
                                                   llvm::Value *v) {
  llvm::LLVMContext &Ctx = builder.getContext();
  llvm::Value *cast = nullptr;
  llvm::Value *load = nullptr;
  if (v->getType()->isPointerTy()) {
    llvm::Type *ptrType = v->getType()->getPointerElementType();
    if (!ptrType->isIntegerTy() && !ptrType->isFloatingPointTy()) {
      // Currently we only handle int and float pointers
      dbgs() << "Non numeric pointers (int and float) are skipped:"
             << *v << " " << *ptrType << "\n";
      return false;
    }
    load = builder.CreateLoad(v);
  } else {
    load = v;
  }

  if (load->getType()->isIntegerTy()) {
    cast = builder.CreateZExtOrBitCast(load, llvm::Type::getInt64Ty(Ctx));
  } else if (load->getType()->isFloatingPointTy()) {
    cast = builder.CreateFPToSI(load, llvm::Type::getInt64Ty(Ctx));
  } else {
    dbgs() << "\nERR. Any value other than int and float is passed to insertHashBuilder\n";
    dbgs() << *load->getType() << "\n";
    return false;
  }
  std::vector<llvm::Value *> arg_values;
  unsigned index = get_random(num_hash);
  usedHashIndices.push_back(index);
  arg_values.push_back(hashPtrs.at(index));
  arg_values.push_back(cast);
  llvm::ArrayRef<llvm::Value *> args(arg_values);

  builder.CreateCall(get_random(2) ? hashFunc1 : hashFunc2, args);
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

bool ObliviousHashInsertionPass::instrumentInst(llvm::Instruction &I) {
  bool hashInserted = false;
  bool isCallGuard = false;
  int protectedArguments = 0;

  if (auto* cmp = llvm::dyn_cast<llvm::CmpInst>(&I)) {
      hashInserted = instrumentCmpInst(cmp);
  } else if (llvm::ReturnInst::classof(&I)) {
    auto *ret = llvm::dyn_cast<llvm::ReturnInst>(&I);
    if (auto *val = ret->getReturnValue()) {
      hashInserted = insertHash(I, val, true);
    }
  } else if (llvm::LoadInst::classof(&I)) {
    auto *load = llvm::dyn_cast<llvm::LoadInst>(&I);
    hashInserted = insertHash(I, load, false);
  } else if (llvm::StoreInst::classof(&I)) {
    auto *store = llvm::dyn_cast<llvm::StoreInst>(&I);
    llvm::Value *v = store->getPointerOperand();
    hashInserted = insertHash(I, v, false);
  } else if (llvm::BinaryOperator::classof(&I)) {
    auto *bin = llvm::dyn_cast<llvm::BinaryOperator>(&I);
    if (bin->getOpcode() == llvm::Instruction::Add) {
      hashInserted = insertHash(I, bin, false);
    }
  } else if (auto *call = llvm::dyn_cast<llvm::CallInst>(&I)) {
      hashInserted = instrumentCallInst(call, protectedArguments);
      isCallGuard = isInstAGuard(I);
  } else if (auto* invoke = llvm::dyn_cast<llvm::InvokeInst>(&I)) {
      hashInserted = instrumentCallInst(invoke, protectedArguments);
      isCallGuard = isInstAGuard(I);
  } else if (auto* getElemPtr = llvm::dyn_cast<llvm::GetElementPtrInst>(&I)) {
      hashInserted = instrumentGetElementPtrInst(getElemPtr);
  }

  if (hashInserted) {
    stats.addNumberOfHashCalls(1);
    stats.addNumberOfProtectedInstructions(1);
    if (isCallGuard) {
        // When call is a guard we compute implicit OH stats
        // See #37
        unsigned int checkeeSize = getUniqueCheckeeFunctionInstructionCount(I);
        if (checkeeSize > 0) {
            dbgs()<<"Implicit protection instructions to add:"<<checkeeSize<<"\n";
        }
        stats.addNumberOfImplicitlyProtectedInstructions(checkeeSize);

      //#20 increment number of protected guard instruction,
      // when at least one of the guard call arguments are
      // incorporated into the hash
      stats.addNumberOfProtectedGuardInstructions(1);

      stats.addNumberOfProtectedGuardArguments(protectedArguments);
    } else {
      stats.addNumberOfProtectedArguments(protectedArguments);
    }
  }

  /// END STATS

  return hashInserted;
}

template <class CallInstTy>
bool ObliviousHashInsertionPass::instrumentCallInst(CallInstTy* call, 
                                                    int& protectedArguments)
{
    bool hashInserted = false;
    llvm::dbgs() << "Processing call instruction..\n";
    call->dump();
    auto called_function = call->getCalledFunction();
    if (called_function == nullptr || called_function->isIntrinsic() ||
            called_function == hashFunc1 || called_function == hashFunc2) {
        return false;
    }

    for (int i = 0; i < call->getNumArgOperands(); ++i) {
        auto* operand = call->getArgOperand(i);
        bool argHashed = false;
        if (auto *const_op = llvm::dyn_cast<llvm::ConstantInt>(operand)) {
            llvm::dbgs() << "***Handling a call instruction***\n";
            argHashed = insertHash(*call, const_op, false);
            if (!argHashed) {
                errs() << "ERR. constant int argument passed to insert hash, but "
                    "failed to hash\n";
                const_op->dump();
            } else {
                ++protectedArguments;
            }
        } else if (auto *load = llvm::dyn_cast<llvm::LoadInst>(operand)) {
            if (!input_dependency_info->isInputDependent(load)) {
                argHashed = insertHash(*load, load, false);
                if (argHashed) {
                    ++protectedArguments;
                } else {
                    errs() << "ERR. constant int argument passed to insert hash, but "
                        "failed to hash\n";
                    load->dump();
                }
            } else {
                llvm::dbgs() << "Can't handle input dependent load operand ";
                load->dump();
            }
        } else {
            llvm::dbgs() << "Can't handle this operand " << *operand
                         << " of the call " << *call << "\n";
        }
        hashInserted = hashInserted || argHashed;
    }
    return hashInserted;
}

bool ObliviousHashInsertionPass::instrumentGetElementPtrInst(llvm::GetElementPtrInst* getElemPtr)
{
    bool hashInserted = insertHash(*getElemPtr, getElemPtr, false);
    // hash constant and input independent indices
    auto idx_it = getElemPtr->idx_begin();
    while (idx_it != getElemPtr->idx_end()) {
        if (auto* constant_idx = llvm::dyn_cast<llvm::Constant>(*idx_it)) {
            hashInserted |= insertHash(*getElemPtr, constant_idx, false);
        } else if (auto* load_inst = llvm::dyn_cast<llvm::LoadInst>(*idx_it)) {
            if (!input_dependency_info->isInputDependent(load_inst)) {
                hashInserted |= insertHash(*getElemPtr, load_inst, false);
            }
        }
        ++idx_it;
    }
    return hashInserted;
}

bool ObliviousHashInsertionPass::instrumentCmpInst(llvm::CmpInst* I)
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
    bool hashInserted = insertHash(*AddInst, val, false);
    if (!hashInserted) {
        errs() << "Potential ERR: insertHash failed for";
        val->dump();
    }
    return hashInserted;
}


void ObliviousHashInsertionPass::insertLogger(llvm::Instruction &I) {
  // no hashing has been done. no meaning to log
  if (usedHashIndices.empty()) {
    return;
  }
  llvm::LLVMContext &Ctx = I.getModule()->getContext();
  llvm::IRBuilder<> builder(&I);
  builder.SetInsertPoint(I.getParent(), builder.GetInsertPoint());

  // logger for cmp instruction should have been added
  if (llvm::CmpInst::classof(&I)) {
    // log the last value which contains hash for this cmp instruction
    // builder.SetInsertPoint(I.getParent(), ++builder.GetInsertPoint());
    insertLogger(builder, I, usedHashIndices.back());
    return;
  }

  unsigned random_hash_idx =
      usedHashIndices.at(get_random(usedHashIndices.size()));
  assert(random_hash_idx < hashPtrs.size());
  if (auto callInst = llvm::dyn_cast<llvm::CallInst>(&I)) {
    auto called_function = callInst->getCalledFunction();
    if (called_function != nullptr && !called_function->isIntrinsic() &&
        called_function != hashFunc1 && called_function != hashFunc2) {
      // always insert logger before call instructions
      insertLogger(builder, I, random_hash_idx);
      return;
    }
  }
  if (get_random(2)) {
    // insert randomly
    insertLogger(builder, I, random_hash_idx);
  }
}
int assertCnt = 1;
void ObliviousHashInsertionPass::insertLogger(llvm::IRBuilder<> &builder,
                                              llvm::Instruction &instr,
                                              unsigned hashToLogIdx) {

  llvm::LLVMContext &Ctx = builder.getContext();
  builder.SetInsertPoint(instr.getParent(), builder.GetInsertPoint());

  ConstantInt *const_int = (ConstantInt *)ConstantInt::get(
      Type::getInt64Ty(Ctx), APInt(64, (assertCnt)*1000000000000));
  std::vector<Value *> values = {hashPtrs.at(hashToLogIdx), const_int};
  ArrayRef<Value *> args(values);
  assertCnt++;
  // Stats add the assert call
  stats.addNumberOfAssertCalls(1);

  builder.CreateCall(logger, args);
}

void ObliviousHashInsertionPass::setup_functions(llvm::Module &M) {
  llvm::LLVMContext &Ctx = M.getContext();
  llvm::ArrayRef<llvm::Type *> params{llvm::Type::getInt64PtrTy(Ctx),
                                      llvm::Type::getInt64Ty(Ctx)};
  llvm::FunctionType *function_type =
      llvm::FunctionType::get(llvm::Type::getVoidTy(Ctx), params, false);
  hashFunc1 = M.getOrInsertFunction("hash1", function_type);
  hashFunc2 = M.getOrInsertFunction("hash2", function_type);

  logger = cast<Function>(
      M.getOrInsertFunction("assert", Type::getVoidTy(M.getContext()),
                            Type::getInt64PtrTy(M.getContext()),
                            Type::getInt64Ty(M.getContext()), NULL));
}

void ObliviousHashInsertionPass::setup_hash_values(llvm::Module &M) {

  stats.setNumberOfHashVariables(num_hash);

  llvm::LLVMContext &Ctx = M.getContext();
  for (int i = 0; i < num_hash; i++) {
    hashPtrs.push_back(new llvm::GlobalVariable(
        M, llvm::Type::getInt64Ty(Ctx), false,
        llvm::GlobalValue::ExternalLinkage,
        llvm::ConstantInt::get(llvm::Type::getInt64Ty(Ctx), 0)));
  }
}

bool ObliviousHashInsertionPass::runOnModule(llvm::Module &M) {
  parse_skip_tags();
  llvm::dbgs() << "Insert hash computation\n";
  bool modified = false;
  unique_id_generator::get().reset();
  srand(time(NULL));
  this->guardMetadataKindID = M.getMDKindID(GUARD_META_DATA);
  if (this->guardMetadataKindID > 0) {
    dbgs() << "'guard' metadata was found in the input bitcode\n";
  } else {
    dbgs() << "No 'guard' metadata was found\n";
  }
  hashPtrs.reserve(num_hash);
  input_dependency_info = getAnalysis<input_dependency::InputDependencyAnalysisPass>().getInputDependencyAnalysis();
  const auto &function_info =
      getAnalysis<FunctionMarkerPass>().get_functions_info();
  llvm::dbgs() << "Recieved marked functions "
               << function_info->get_functions().size() << "\n";
  const auto &function_filter_info =
      getAnalysis<FunctionFilterPass>().get_functions_info();
  llvm::dbgs() << "Recieved filter functions "
               << function_filter_info->get_functions().size() << "\n";
  const auto &function_callsite_data =
      getAnalysis<FunctionCallSiteInformationPass>().getAnalysisResult();

  int countProcessedFuncs = 0;
  // Get the function to call from our runtime library.
  setup_functions(M);
  // Insert Globals
  setup_hash_values(M);

  for (auto &F : M) {
    bool hashUpdated = false;
    // No input dependency info for declarations and instrinsics.
    if (F.isDeclaration() || F.isIntrinsic()) {
      continue;
    }
    if (function_filter_info->get_functions().size() != 0 &&
        !function_filter_info->is_function(&F)) {
      llvm::dbgs() << " Skipping function per FilterFunctionPass:"
                   << F.getName() << "\n";
      continue;
    }
    llvm::dbgs() << " Processing function:" << F.getName() << "\n";
    countProcessedFuncs++;

    auto F_input_dependency_info = input_dependency_info->getAnalysisInfo(&F);
    if (!F_input_dependency_info) {
      llvm::dbgs() << "No input dep info for function " << F.getName()
                   << ". Skip\n";
      continue;
    }

    // no hashes for functions called from non deterministc blocks
    if (F_input_dependency_info->isInputDepFunction()) {
      llvm::dbgs() << "Function " << F.getName()
                   << " is input dependent. Skip\n";
      continue;
    }

    /*if (!function_calls.is_function_input_independent(&F)) {
     llvm::dbgs() << "Skipping input dependent function "<<F.getName()<<"\n";
     continue;
   } else {
     llvm::dbgs()<<"Including input independent function "<<F.getName()<<"\n";
   }*/
    llvm::LoopInfo &LI =
        getAnalysis<llvm::LoopInfoWrapperPass>(F).getLoopInfo();
    for (auto &B : F) {
      if (F_input_dependency_info->isInputDependentBlock(&B) &&
          &F.back() != &B) {
        continue;
      }
      for (auto &I : B) {
        if (auto phi = llvm::dyn_cast<llvm::PHINode>(&I)) {
          continue;
        }
        if (!F_input_dependency_info->isInputDependent(&I)) {
          // llvm::dbgs() << "I: " << I << "\n";
          /*if (auto callInst = llvm::dyn_cast<llvm::CallInst>(&I)) {
               llvm::dbgs()<<"Input independent call instruction: ";
               callInst->print(llvm::dbgs(),true);
               llvm::dbgs()<<"\n";
          }*/
          // skip instrumenting instructions whose tag matches the skip tag list
          if (this->hasTagsToSkip && I.hasMetadataOtherThanDebugLoc()) {
            llvm::dbgs() << "Found instruction with tags ad we have set tags\n";
            for (auto tag : skipTags) {
              llvm::dbgs() << tag << "\n";
              if (auto *metadata = I.getMetadata(tag)) {
                llvm::dbgs() << "Skipping tagged instruction: ";
                I.print(llvm::dbgs(), true);
                llvm::dbgs() << "\n";
                continue;
              }
            }
          }
          if (auto callInst = llvm::dyn_cast<llvm::CallInst>(&I)) {
            auto calledF = callInst->getCalledFunction();
            if (calledF && calledF->getName() == "assert") {
              continue;
            }
            // evaluate dependency of call load arguments
          }

          hashUpdated = instrumentInst(I);
          modified = true;
        }
        if (function_callsite_data.isFunctionCalledInLoop(&F)) {
          llvm::dbgs() << "InsertLogger skipped function:" << F.getName()
                       << " because it is called from a loop!\n";
          continue;
        }
        auto loop = LI.getLoopFor(&B);
        if (loop != nullptr) {
          continue;
        }
        // We shouldn't insert asserts when there was no hash update, see #9
        if (!hashUpdated) {
          llvm::dbgs() << "InsertLogger skipped because there was no hash "
                          "update in between!\n";
          continue;
        }
        if (function_info->get_functions().size() == 0 ||
            !function_info->is_function(&F)) {
          // Begin #24
          // If the function has multiple callsites it should get an assert with
          // multiple correct hash values, otherwise patcher keeps the last call
          // as the correct hash. Boom! This breaks OH and signals tampering...
          // for now we insert no asserts in functions with multiple callsites
          // moving forward we should get asserts with multiple place holders
	  // There is already an issue for this - #22
          int callsites =
              function_callsite_data.getNumberOfFunctionCallSites(&F);
          llvm::dbgs() << "InsertLogger evaluating function:" << F.getName()
                       << " callsites detected =" << callsites << "\n";
          if (callsites > 1) {
            llvm::dbgs()
                << "InsertLogger skipped function:" << F.getName()
                << " because it has more than one call site, see #24.!\n";
            continue;
          }
          // END #24
          hashUpdated = false;
          insertLogger(I);
          llvm::dbgs() << "InsertLogger included function:" << F.getName()
                       << " because it is not in the skip  assert list!\n";

          modified = true;
        } else {
          llvm::dbgs() << "InsertLogger skipped function:" << F.getName()
                       << " because it is in the skip assert list!\n";
        }
      }
    }
  }
  if (!DumpOHStat.empty()) {
    dbgs() << "OH stats is requested, dumping stat file...\n";
    stats.dumpJson(DumpOHStat);
  }

  // Make sure OH only processed filter function list
  if (countProcessedFuncs != function_filter_info->get_functions().size() &&
      function_filter_info->get_functions().size() > 0) {
    errs() << "ERR. processed " << countProcessedFuncs
           << " function, while filter count is "
           << function_filter_info->get_functions().size() << "\n";
    exit(1);
  }
  //  dbgs()<<"runOnModule is done\n";
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
