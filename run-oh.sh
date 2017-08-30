#!/bin/bash

INPUT_DEP_PATH=/usr/local/lib/
OH_PATH=/home/sip/sip-oblivious-hashing
OH_LIB=$OH_PATH/build/lib
bitcode=$1
input=$2

# compiling external libraries to bitcodes
clang++-3.9 $OH_PATH/assertions/asserts.cpp -fno-use-cxa-atexit -std=c++0x -c -emit-llvm -o $OH_PATH/assertions/asserts.bc
clang-3.9 $OH_PATH/hashes/hash.c -c -fno-use-cxa-atexit -emit-llvm -o $OH_PATH/hashes/hash.bc
clang++-3.9 $OH_PATH/assertions/logs.cpp -fno-use-cxa-atexit -std=c++0x -c -emit-llvm -o $OH_PATH/assertions/logs.bc

# Running hash insertion pass
opt-3.9 -load $INPUT_DEP_PATH/libInputDependency.so -load  $OH_LIB/liboblivious-hashing.so $1 -oh-insert -num-hash 1 -o out.bc
# Linking with external libraries
llvm-link-3.9 out.bc $OH_PATH/hashes/hash.bc -o out.bc
llvm-link-3.9 out.bc $OH_PATH/assertions/asserts.bc -o out.bc
llvm-link-3.9 out.bc $OH_PATH/assertions/logs.bc -o out.bc

# precompute hashes
clang++-3.9 -lncurses -rdynamic -std=c++0x out.bc -o out
./out $input
###rm out
#

# Running assertion insertion pass
opt-3.9 -load $INPUT_DEP_PATH/libInputDependency.so -load $OH_LIB/liboblivious-hashing.so out.bc -insert-asserts -o protected.bc
# Compiling to final protected binary
clang++-3.9 -lncurses -rdynamic -std=c++0x protected.bc -o protected

