This is a simple skeleton pass which uses Input Dependency Analiser results. It prints out all input dependent instructions in a bitcode.

# How to build skeleton pass

mkdir build
cd build
cmake ../
make

# How to run the pass

opt -load /usr/local/lib/libInputDependency.so -load build/lib/libskeleton.so bitcode.bc -input-dep-skeleton -o out.bc

Note you would need to explicitly load input dependency library, as it is not a part of llvm framework. It is located under directory /usr/local/lib/.
Corresponding header file are under directory /usr/local/include/input-dependency.

# Input Dependency Analysis pass

Input dependency analysis pass gets as an input llvm bitcode and collects information about input dependent and input independent instructions. It considers both data flow dependencies and control flow dependencies. An instruction is said to be input dependent by data flow, if any of its arguments is input dependent. An instruction is input dependent by control flow if it is in a branch, which condition is input dependent. Primary sources of inputs are arguments of main functions. All external functions which are considered as input sources, if not stated otherwise.


# Using input dependency in your pass

To use Input dependency analysis information in your pass you need to register it as a required pass

    AU.addRequired<input_dependency::InputDependencyAnalysis>();

Then get it's information:
    
    const auto& input_dependency_info = getAnalysis<input_dependency::InputDependencyAnalysis>();

InputDependencyAnalysis provides interface to request information about instruction input dependency:

       bool isInputDependent(llvm::Instruction* instr) const;

# Runing input dependency analysis as standalone

       opt -load /usr/local/lib/libInputDependency.so bitcode.bc -input-dep -o out.bc


# Other Utility passes
    
To have input dependency information visualized in a dot graph:

       opt -load /usr/local/lib/libInputDependency.so bitcode.bc -print-dot -o out.bc

The output of this pass are dot files for each function in bitcode. To get graph image run:
    dot -Tpng dotfilename -o imagename

In a graph you can see input dependent instructions marked with \*\*\*
 
To get simple statistic information about input dependent instructions in a bitcode run:

       opt -load /usr/local/lib/libInputDependency.so bitcode.bc inputdep-statistics -o out.bc
 


 
