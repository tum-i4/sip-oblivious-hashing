#pragma once

#include <vector>
#include <string>

namespace llvm {
class Module;
class Function;
}

namespace oh {

class FunctionRunner
{
public:
    FunctionRunner(llvm::Module* M);

    int run(llvm::Function* F, const std::vector<std::string>& extra_modules);

private:
    llvm::Module* m_module;
    std::string m_bitcodeName;
}; // class FunctionRunner

} // namespace oh

