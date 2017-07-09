#!/bin/bash

INPUT_DEP_PATH=/usr/local/lib/
OH_LIB=./build/lib
bitcode=$1
input=$2

opt -load $INPUT_DEP_PATH/libInputDependency.so -load  $OH_LIB/liboblivious-hashing.so $1 -oh-insert -num-hash 1 -o out.bc
llvm-link out.bc ./hashes/hash.bc -o out.bc
llvm-link out.bc ./assertions/asserts.bc -o out.bc

# dumps hashes
clang++ -lncurses -rdynamic -std=c++0x -stdlib=libc++ out.bc -o out
./out $input
###rm out
#
opt -load $INPUT_DEP_PATH/libInputDependency.so -load $OH_LIB/liboblivious-hashing.so out.bc -insert-asserts -o protected.bc
clang++ -lncurses -rdynamic -std=c++0x -stdlib=libc++ protected.bc -o protected

