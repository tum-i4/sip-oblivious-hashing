add_library(oblivious-hashing MODULE 
	ObliviousHashInsertion.cpp 
	AssertionInsertionPass.cpp 
	AssertionFinalizePass.cpp 
	NonDeterministicBasicBlocksAnalysis.cpp
	AssertFunctionMarkPass.cpp
	Stats.cpp
	)

#Use C++ 11 to compile our pass(i.e., supply - std = c++ 11).
target_compile_features(oblivious-hashing PRIVATE cxx_range_for cxx_auto_type)
#LLVM is(typically) built with no C++ RTTI.We need to match that;
#otherwise, we'll get linker errors about missing RTTI data.
set_target_properties(oblivious-hashing PROPERTIES COMPILE_FLAGS "-lInputDependency -std=c++11 -fno-rtti -g")
