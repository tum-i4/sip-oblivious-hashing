#!/bin/bash

INPUT_DEP_PATH=/usr/local/lib/
OH_LIB=./build/lib
bitcode=$1
input=$2

# compiling external libraries to bitcodes
clang++-3.9 $OH_LIB/assertions/asserts.cpp -std=c++0x -c -emit-llvm -o $OH_LIB/assertions/asserts.bc
clang-3.9 $OH_LIB/hashes/hash.c -c -emit-llvm -o $OH_LIB/hashes/hash.bc

# Running hash insertion pass
opt-3.9 -load $INPUT_DEP_PATH/libInputDependency.so -load  $OH_LIB/liboblivious-hashing.so $1 -oh-insert -num-hash 1 -o out.bc
# Linking with external libraries
llvm-link-3.9 out.bc ./hashes/hash.bc -o out.bc
llvm-link-3.9 out.bc ./assertions/asserts.bc -o out.bc

# precompute hashes
clang++-3.9 -lncurses -rdynamic -std=c++0x out.bc -o out
./out $input
###rm out
#

# Running assertion insertion pass
opt-3.9 -load $INPUT_DEP_PATH/libInputDependency.so -load $OH_LIB/liboblivious-hashing.so out.bc -insert-asserts -o protected.bc
# Compiling to final protected binary
clang++-3.9 -lncurses -rdynamic -std=c++0x protected.bc -o protected

