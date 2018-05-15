#include "FunctionRunner.h"

#include "llvm/IR/BasicBlock.h"
#include "llvm/IR/Function.h"
#include "llvm/IR/IRBuilder.h"
#include "llvm/IR/LLVMContext.h"

#include "llvm/Bitcode/ReaderWriter.h"
#include "llvm/Support/SourceMgr.h"
#include "llvm/Support/FileSystem.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/Support/ToolOutputFile.h"
#include "llvm/Support/Debug.h"
#include "llvm/Support/FormattedStream.h"
#include "llvm/IRReader/IRReader.h"
#include "llvm/Support/Signals.h"
#include "llvm/Support/PrettyStackTrace.h"

#include <fstream>
#include <system_error>
#include <memory>

#include <iostream>
#include <stdexcept>
#include <stdio.h>
#include <string>

namespace oh {

namespace {

std::string write_bitcode(llvm::Module* M)
{
    std::string bitcode_name = M->getName();
    bitcode_name += ".oh_instrumented";

    std::unique_ptr<llvm::tool_output_file> Out;
    std::error_code EC;
    Out.reset(new llvm::tool_output_file(bitcode_name, EC, llvm::sys::fs::F_None));
    if (EC) {
        llvm::dbgs() << EC.message() << '\n';
        return "";
    }


    llvm::raw_ostream *OS = &Out->os();

    llvm::dbgs() << "Saving oh_instrumented module " << bitcode_name << "\n";
    llvm::WriteBitcodeToFile(M, *OS, true);
    Out->keep();
    return bitcode_name;
}


std::string get_command_string(const std::string& f_name,
                               const std::string& bitcode_name,
                               const std::vector<std::string>& extra_modules)
{
    std::string cmd_name = "lli ";
    cmd_name += "-entry-function=";
    cmd_name += f_name;
    if (!extra_modules.empty()) {
        for (const auto& obj : extra_modules) {
            cmd_name += " -extra-module=";
            cmd_name += obj;
        }
    }
    cmd_name += " ";
    cmd_name += bitcode_name;
    return cmd_name;
}

int extract_expected_hash_from_output(const std::string& result, std::string::size_type assert_pos)
{
    // assertion looks like
    // Assert: 32==300000....
    auto equals_pos = result.find("==");
    if (equals_pos == std::string::npos) {
        return -1;
    }
    const std::string hash_str = result.substr(assert_pos + 8, equals_pos - assert_pos - 8);
    try {
        int hash = std::stoi(hash_str);
        return hash;
    } catch (const std::invalid_argument& exp) {
        llvm::dbgs() << "Invalid value for expected hash " << hash_str << "\n";
    }
    return -1;
}

}


FunctionRunner::FunctionRunner(llvm::Module* M)
    : m_module(M)
{
    m_bitcodeName = write_bitcode(M);
}

int FunctionRunner::run(llvm::Function* F, const std::vector<std::string>& extra_modules)
{
    llvm::dbgs() << "Running function " << F->getName() << "\n";
    std::string cmd = get_command_string(F->getName(), m_bitcodeName, extra_modules);
    char buffer[128];
    std::string result = "";
    FILE* pipe = popen(cmd.c_str(), "r");
    const std::string pattern = "Assert:";
    std::string::size_type pos = std::string::npos;
    if (!pipe) throw std::runtime_error("popen() failed!");
    try {
        while (!feof(pipe)) {
            if (fgets(buffer, 128, pipe) != NULL) {
                result += buffer;
            }
            pos = result.find(pattern);
            if (pos != std::string::npos) {
                break;
            }
        }
    } catch (...) {
        pclose(pipe);
        llvm::dbgs() << "Error while parsing lli output\n";
        return -1;
    }
    pclose(pipe);
    if (pos == std::string::npos) {
        llvm::dbgs() << "Pattern was not found in the output\n";
        return -1;
    }
    //llvm::dbgs() << result << "\n";
    int hash = extract_expected_hash_from_output(result, pos);
    return hash;

//    llvm::InitializeNativeTarget();
//    llvm::InitializeNativeTargetAsmPrinter();
//    llvm::InitializeNativeTargetAsmParser();
//
//    llvm::Module* Mod = m_module.get();
//    llvm::EngineBuilder builder(std::move(m_module));
//    builder.setCodeModel(llvm::CodeModel::JITDefault);
//    std::string ErrorMsg;
//    builder.setErrorStr(&ErrorMsg);
//    builder.setEngineKind(llvm::EngineKind::JIT);
//    builder.setUseOrcMCJITReplacement(false);
}

}

