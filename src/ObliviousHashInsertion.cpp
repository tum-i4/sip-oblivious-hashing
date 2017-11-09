#include "ObliviousHashInsertion.h"
//#include "AssertFunctionMarkPass.h"
#include "NonDeterministicBasicBlocksAnalysis.h"
#include "Utils.h"
#include "input-dependency/InputDependencyAnalysis.h"
#include "input-dependency/InputDependentFunctions.h"
#include "llvm/Analysis/LoopInfo.h"
#include "llvm/IR/BasicBlock.h"
#include "llvm/IR/Constants.h"
#include "llvm/IR/Function.h"
#include "llvm/IR/IRBuilder.h"
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
#include <vector>
#include "../../self-checksumming/src/FunctionMarker.h"
using namespace llvm;
using namespace std;
namespace oh {

namespace {
unsigned get_random(unsigned range) { return rand() % range; }
}

char ObliviousHashInsertionPass::ID = 0;
const std::string GUARD_META_DATA = "guard"; 

static cl::opt<std::string> DumpOHStat(
		    "dump-oh-stat", cl::Hidden,
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
  AU.addRequired<input_dependency::InputDependencyAnalysis>();
  AU.addRequired<input_dependency::InputDependentFunctionsPass>();
  AU.addRequired<NonDeterministicBasicBlocksAnalysis>();
  AU.addRequired<llvm::LoopInfoWrapperPass>();
  AU.addRequired<FunctionMarkerPass>();
}

void ObliviousHashInsertionPass::insertHash(llvm::Instruction &I,
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
  bool isGuard  = false;  
  if (auto *metadata = I.getMetadata(GUARD_META_DATA)) {
	  isGuard = true;
  }
  //dbgs()<<"Instruction to instrument:";
  //I.print(dbgs(),true);
  //dbgs()<<"\n";
  insertHashBuilder(builder, v, isGuard);
}

bool ObliviousHashInsertionPass::insertHashBuilder(llvm::IRBuilder<> &builder,
                                                   llvm::Value *v, bool isGuard) {
  llvm::LLVMContext &Ctx = builder.getContext();
  llvm::Value *cast;
  llvm::Value *load;
  if (v->getType()->isPointerTy()) {
    llvm::Type *ptrType = v->getType()->getPointerElementType();
    //ptrType->print(dbgs(), true);
    //dbgs() << "\n";
    if (!ptrType->isIntegerTy() && !ptrType->isFloatingPointTy()) {
      //Currently we only handle int and float pointers
      dbgs() << "Non numeric pointers (int and float) are skipped:";
      v->print(dbgs(), true);
      ptrType->print(dbgs(), true);
      dbgs() << "\n";
      return false;
    }
    load = builder.CreateLoad(v);
    //llvm::dbgs() << "creating load for pointer ";
    //v->print(llvm::dbgs(), true);
    //llvm::dbgs() << "\n";
  } else {
    load = v;
  }

  if (load->getType()->isIntegerTy())
    cast = builder.CreateZExtOrBitCast(load, llvm::Type::getInt64Ty(Ctx));
  /*else if (load->getType()->isPtrOrPtrVectorTy()) {
    // This should never happen, pointer to pointer should not reach here
    dbgs()<<"ERR.  insertHashBuilder\n";
    assert(false);
  } */else if (load->getType()->isFloatingPointTy())
    cast = builder.CreateFPToSI(load, llvm::Type::getInt64Ty(Ctx));
  else
  {
    dbgs()<<"\nERR. Any value other than int and float is passed to insertHashBuilder\n";
    load->getType()->print(dbgs(), true);
    dbgs()<<"\n";
    return false;//assert(false);
  }
  std::vector<llvm::Value *> arg_values;
  unsigned index = get_random(num_hash);
  usedHashIndices.push_back(index);
  arg_values.push_back(hashPtrs.at(index));
  arg_values.push_back(cast);
  llvm::ArrayRef<llvm::Value *> args(arg_values);

  //STATS: add the instruction  to stats
  stats.addNumberOfHashCalls(1);
  stats.addNumberOfProtectedInstructions(1);
  if(isGuard) stats.addNumberOfProtectedGuardInstructions(1);
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
  if (llvm::CmpInst::classof(&I)) {
    auto *cmp = llvm::dyn_cast<llvm::CmpInst>(&I);
    llvm::LLVMContext &Ctx = I.getModule()->getContext();
    llvm::IRBuilder<> builder(&I);
    builder.SetInsertPoint(I.getParent(), ++builder.GetInsertPoint());

    // Insert the transformation of the cmp output into something more usable by
    // the hash function.
    llvm::Value *cmpExt =
        builder.CreateZExtOrBitCast(cmp, llvm::Type::getInt8Ty(Ctx));
    llvm::Value *val = builder.CreateAdd(
        builder.CreateMul(
            llvm::ConstantInt::get(llvm::Type::getInt8Ty(Ctx), 64),
            builder.CreateAdd(
                cmpExt, llvm::ConstantInt::get(llvm::Type::getInt8Ty(Ctx), 1))),
        llvm::ConstantInt::get(llvm::Type::getInt8Ty(Ctx),
                               cmp->getPredicate()));
  bool isGuard  = false;  
  if (auto *metadata = I.getMetadata(GUARD_META_DATA)) {
	  isGuard = true;
  }
    insertHashBuilder(builder, val, isGuard);
  }
  if (llvm::ReturnInst::classof(&I)) {
    auto *ret = llvm::dyn_cast<llvm::ReturnInst>(&I);
    auto *val = ret->getReturnValue();
    if (val) {
      insertHash(I, val, true);
    }
  }
  if (llvm::LoadInst::classof(&I)) {
    auto *load = llvm::dyn_cast<llvm::LoadInst>(&I);
    insertHash(I, load, false);
  }
  if (llvm::StoreInst::classof(&I)) {
    auto *store = llvm::dyn_cast<llvm::StoreInst>(&I);
    llvm::Value *v = store->getPointerOperand();
    insertHash(I, v, false);
  }
  if (llvm::BinaryOperator::classof(&I)) {
    auto *bin = llvm::dyn_cast<llvm::BinaryOperator>(&I);
    if (bin->getOpcode() == llvm::Instruction::Add) {
      insertHash(I, bin, false);
    }
  }
  if (llvm::CallInst::classof(&I)) {
    auto *call = llvm::dyn_cast<llvm::CallInst>(&I);
    auto called_function = call->getCalledFunction();
    if (called_function == nullptr || called_function->isIntrinsic() ||
        called_function == hashFunc1 || called_function == hashFunc2) {
      return false;
    }
    llvm::dbgs() << "Processing call instruction..\n";
    call->print(llvm::dbgs(), true);
    llvm::dbgs() << "\n";
    for (int i = 0; i < call->getNumArgOperands(); ++i) {
      if (llvm::ConstantInt::classof(call->getArgOperand(i))) {
        auto *operand =
            llvm::dyn_cast<llvm::ConstantInt>(call->getArgOperand(i));
        llvm::dbgs() << "***Handling a call instruction***\n";
	//insertHash which increments
	//the number or protected instructions. 
	//while this is just an argument of a call inst
	//therefore, we subtract 1 to even out the result
	stats.addNumberOfProtectedInstructions(-1);
	stats.addNumberOfProtectedArguments(1);
	if (auto *metadata = I.getMetadata(GUARD_META_DATA)) {
		stats.addNumberOfProtectedGuardInstructions(-1);
		stats.addNumberOfProtectedGuardArguments(1);
	}

        insertHash(I, operand, false);
      } else if (llvm::LoadInst::classof(call->getArgOperand(i))) {
        auto *load = llvm::dyn_cast<llvm::Instruction>(call->getArgOperand(i));
	//instrumentInst will call insertHash which increments
	//the number or protected instructions. 
	//while this is just an argument of a call inst
	//therefore, we subtract 1 to even out the result
	stats.addNumberOfProtectedInstructions(-1);
	stats.addNumberOfProtectedArguments(1);
	if (auto *metadata = I.getMetadata(GUARD_META_DATA)) {
		stats.addNumberOfProtectedGuardInstructions(-1);
		stats.addNumberOfProtectedGuardArguments(1);
	}
        instrumentInst(*load);
      } else {
        llvm::dbgs() << "Can't handle this operand ";
        call->getArgOperand(i)->print(llvm::dbgs(), true);
        llvm::dbgs() << " of the call ";
        call->print(llvm::dbgs(), true);
        llvm::dbgs() << "\n";
      }
    }
  }
  /*if (llvm::AtomicRMWInst::classof(&I)) {
      auto *armw = llvm::dyn_cast<llvm::AtomicRMWInst>(&I);
      llvm::dbgs() << "rmw: ";
      armw->getValOperand()->getType()->print(llvm::dbgs());
      llvm::dbgs() << "\n";
  }*/
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
  vector<Value *> values = {hashPtrs.at(hashToLogIdx), const_int};
  ArrayRef<Value *> args(values);
  // CallInst *assertI = CallInst::Create(logger, args);
  /*if (after) {
    assertI->insertAfter(instr);
  } else {
    assertI->insertBefore(instr);
  }*/

  assertCnt++;

  // std::vector<llvm::Value *> arg_values;
  // unsigned id = unique_id_generator::get().next();
  // llvm::dbgs() << "ID  " << id << " for instruction " << instr << "\n";
  // llvm::Value *id_value =
  //   llvm::ConstantInt::get(llvm::Type::getInt64Ty(Ctx), 1000000000000);
  // arg_values.push_back(hashPtrs.at(hashToLogIdx));
  // arg_values.push_back(id_value);
  // llvm::ArrayRef<llvm::Value *> args(arg_values);
 
  //Stats add the assert call
  stats.addNumberOfAssertCalls(1);
  
  builder.CreateCall(logger, args);
}

void ObliviousHashInsertionPass::end_logging(llvm::Instruction &I) {
  llvm::LLVMContext &Ctx = I.getParent()->getParent()->getContext();
  llvm::IRBuilder<> builder(&I);
  builder.SetInsertPoint(I.getParent(), builder.GetInsertPoint());

  std::vector<llvm::Value *> arg_values;
  llvm::Value *zero_val =
      llvm::ConstantInt::get(llvm::Type::getInt32Ty(Ctx), 0);
  arg_values.push_back(zero_val);
  arg_values.push_back(
      llvm::ConstantPointerNull::get(llvm::Type::getInt64PtrTy(Ctx)));
  llvm::ArrayRef<llvm::Value *> args(arg_values);
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

  // arguments of logger are line and column number of instruction and hash
  // variable to log
  /*llvm::ArrayRef<llvm::Type *> logger_params{llvm::Type::getInt64PtrTy(Ctx),
  llvm::Type::getInt64Ty(Ctx), NULL};
  llvm::FunctionType *logger_type =
      llvm::FunctionType::get(llvm::Type::getVoidTy(Ctx), logger_params, false);
  logger = M.getOrInsertFunction("assert", logger_type);
  */
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

  hashPtrs.reserve(num_hash);
  const auto &input_dependency_info =
      getAnalysis<input_dependency::InputDependencyAnalysis>();
  const auto &function_calls =
      getAnalysis<input_dependency::InputDependentFunctionsPass>();
  const auto &non_det_blocks =
      getAnalysis<NonDeterministicBasicBlocksAnalysis>();
  //const auto &assert_function_info =
  //    getAnalysis<AssertFunctionMarkPass>().get_assert_functions_info();
  const auto &function_info = getAnalysis<FunctionMarkerPass>().get_functions_info();
  llvm::dbgs() << "Recieved marked functions "<<function_info->get_functions().size()<<"\n";
  // Get the function to call from our runtime library.
  setup_functions(M);
  // Insert Globals
  setup_hash_values(M);

  for (auto &F : M) {
    // No input dependency info for declarations and instrinsics.
    if (F.isDeclaration() || F.isIntrinsic()) {
      continue;
    }
    llvm::dbgs() << " Processing function:" << F.getName() << "\n";
    // no hashes for functions called from non deterministc blocks
    if (!function_calls.is_function_input_independent(&F)) {
      continue;
    }
    llvm::LoopInfo &LI =
        getAnalysis<llvm::LoopInfoWrapperPass>(F).getLoopInfo();
    for (auto &B : F) {
      if (non_det_blocks.is_block_nondeterministic(&B) && &F.back() != &B) {
        continue;
      }
      for (auto &I : B) {
        if (auto phi = llvm::dyn_cast<llvm::PHINode>(&I)) {
          continue;
        }
        if (auto callInst = llvm::dyn_cast<llvm::CallInst>(&I)) {
          auto calledF = callInst->getCalledFunction();
          if (calledF && calledF->getName() == "assert") {
            continue;
          }
        }
        if (input_dependency_info.isInputDependent(&I)) {
          if (auto callInst = llvm::dyn_cast<llvm::CallInst>(&I)) {
            llvm::dbgs() << "Input dependent call instruction: ";
            callInst->print(llvm::dbgs(), true);
            llvm::dbgs() << "\n";

            if (callInst->getCalledFunction()->getName() == "guardMe")
              llvm::dbgs()<<"@Anahit: guardMe is marked as input dependent...";
              goto l1;
          }
          // llvm::dbgs() << "D: " << I << "\n";
        } else {
        l1:
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

          instrumentInst(I);
          modified = true;
        }
        auto loop = LI.getLoopFor(&B);
        if (loop != nullptr) {
          continue;
        }
        // Filter assert functions, unless there is no assert function
        // specified,
        // in which case all functions are good to go
        /*if (assert_function_info.get_assert_functions().size() == 0 ||
            !assert_function_info.is_assert_function(&F)) {
          insertLogger(I);
          llvm::dbgs() << "InsertLogger included function:" << F.getName()
                       << " because it is not in the skip  assert list!\n";

          modified = true;
        } else {
          llvm::dbgs() << "InsertLogger skipped function:" << F.getName()
                       << " because it is in the skip assert list!\n";
        }*/
        if (function_info->get_functions().size() == 0 ||
            !function_info->is_function(&F)) {
          insertLogger(I);
          //llvm::dbgs() << "InsertLogger included function:" << F.getName()
          //             << " because it is not in the skip  assert list!\n";

          modified = true;
        } else {
          llvm::dbgs() << "InsertLogger skipped function:" << F.getName()
                       << " because it is in the skip assert list!\n";
        }

      }
    }
  }
  if(!DumpOHStat.empty()){
    dbgs()<<"OH stats is requested, dumping stat file...\n";
    stats.dumpJson(DumpOHStat);
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
