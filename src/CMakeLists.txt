add_library(oblivious-hashing MODULE 
	ObliviousHashInsertion.cpp 
	AssertionInsertionPass.cpp 
	AssertionFinalizePass.cpp 
	AssertFunctionMarkPass.cpp
	Stats.cpp
    FunctionCallSitesInformation.cpp
    FunctionOHPaths.cpp
    Slicer.cpp
    FunctionRunner.cpp
	)

#Use C++ 11 to compile our pass(i.e., supply - std = c++ 11).
target_compile_features(oblivious-hashing PRIVATE cxx_range_for cxx_auto_type)
#LLVM is(typically) built with no C++ RTTI.We need to match that;
#otherwise, we'll get linker errors about missing RTTI data.

#find_library(LLVM_EXECUTION_ENGINE_LIB_LOCATION "libLLVMExecutionEngine.a")
#message(log ${LLVM_EXECUTION_ENGINE_LIB_LOCATION})
#
#find_library(LLVM_INTERPRETER_LIB_LOCATION "libLLVMInterpreter.a")
#message(log ${LLVM_INTERPRETER_LIB_LOCATION})
#
#find_library(LLVM_MCJIT_LIB_LOCATION "libLLVMMCJIT.a")
#message(log ${LLVM_MCJIT_LIB_LOCATION})
#
##find_library(LLVM_OBJECT_LIB_LOCATION "libLLVMObject.a")
##message(log ${LLVM_OBJECT_LIB_LOCATION})
#
#find_library(LLVM_ORCJIT_LIB_LOCATION "libLLVMOrcJIT.a")
#message(log ${LLVM_ORCJIT_LIB_LOCATION})
#
#find_library(LLVM_RUNTIMEDYLD_LIB_LOCATION "libLLVMRuntimeDyld.a")
#message(log ${LLVM_RUNTIMEDYLD_LIB_LOCATION})
#
#find_library(LLVM_SELECTIONDAG_LIB_LOCATION "libLLVMSelectionDAG.a")
#message(log ${LLVM_SELECTIONDAG_LIB_LOCATION})
#
##find_library(LLVM_NATIVE_LIB_LOCATION "libLLVMnative.a")
##message(log ${LLVM_NATIVE_LIB_LOCATION})
#
#
#target_link_libraries(oblivious-hashing PUBLIC "${LLVM_EXECUTION_ENGINE_LIB_LOCATION}" PUBLIC "${LLVM_INTERPRETER_LIB_LOCATION}" PUBLIC "${LLVM_MCJIT_LIB_LOCATION}" PUBLIC "${LLVM_ORCJIT_LIB_LOCATION}" PUBLIC "${LLVM_RUNTIMEDYLD_LIB_LOCATION}" PUBLIC "${LLVM_SELECTIONDAG_LIB_LOCATION}")

set_target_properties(oblivious-hashing PROPERTIES COMPILE_FLAGS "-lInputDependency -std=c++11 -fno-rtti -g")

