#include "AssertFunctionMarkPass.h"

#include "llvm/IR/Function.h"
#include "llvm/IR/LegacyPassManager.h"
#include "llvm/IR/Module.h"
#include "llvm/Support/CommandLine.h"
#include "llvm/Support/Debug.h"
#include "llvm/Support/Error.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/Transforms/IPO/PassManagerBuilder.h"

#include <cxxabi.h>
#include <fstream>

namespace oh {

namespace {

std::string demangle(const std::string &mangled_name) {
  int status = -1;
  char *demangled =
      abi::__cxa_demangle(mangled_name.c_str(), NULL, NULL, &status);
  if (status == 0) {
    return std::string(demangled);
  }
  // else {
  //    llvm::dbgs() << "Failed to demangle the name " << mangled_name << "\n";
  //}
  return std::string();
}

void extract_function_name(std::string &full_name) {
  auto name_end = full_name.find_first_of("(");
  if (name_end != std::string::npos) {
    full_name = full_name.substr(0, name_end);
  }
}
}

void AssertFunctionInformation::collect_assert_functions(
    const std::string &file_name, llvm::Module &M) {
  llvm::dbgs() << "in collect\n";
  std::ifstream functions_strm(file_name);
  if (!functions_strm.is_open()) {
    llvm::dbgs() << " failed to open file\n";
    return;
  }
  std::string name;
  std::unordered_set<std::string> assert_function_names;
  // for( std::string name; getline(functions_strm, name ); ){
  while (!functions_strm.eof()) {
    functions_strm >> name;
    llvm::dbgs() << "here!:" << name << "\n";
    assert_function_names.insert(name);
  }
  llvm::dbgs() << "got assert function names\n";
  for (auto &F : M) {
    llvm::dbgs() << "demangled function\n";
    auto demangled_name = demangle(F.getName());
    if (demangled_name.empty()) {
      demangled_name = F.getName();
    }
    extract_function_name(demangled_name);
    if (assert_function_names.find(demangled_name) !=
        assert_function_names.end()) {
      llvm::dbgs() << "Add assert function " << demangled_name << "\n";
      add_assert_function(&F);
    }
  }
}

void AssertFunctionInformation::add_assert_function(llvm::Function *F) {
  m_assert_functions.insert(F);
}

bool AssertFunctionInformation::is_assert_function(llvm::Function *F) const {
  return m_assert_functions.find(F) != m_assert_functions.end();
}

const AssertFunctionInformation::FunctionSet &
AssertFunctionInformation::get_assert_functions() const {
  return m_assert_functions;
}
void AssertFunctionMarkPass::getAnalysisUsage(llvm::AnalysisUsage &AU) const {
  AU.setPreservesAll();
}
static llvm::cl::opt<std::string> InputFilename(
    "assert-functions",
    llvm::cl::desc("Specify input filename for Assert function mark pass"),
    llvm::cl::value_desc("filename"));

char AssertFunctionMarkPass::ID = 0;

bool AssertFunctionMarkPass::runOnModule(llvm::Module &M) {
  llvm::dbgs() << "In assert mark pass filename:" << InputFilename << "\n";
  if (!InputFilename.empty()) {
    m_assert_functions_info.collect_assert_functions(InputFilename, M);
  }
  return false;
}
static llvm::RegisterPass<AssertFunctionMarkPass>
    X("mark-functions", "Marks functions in a given file as assert functions");
} // namespace oh
