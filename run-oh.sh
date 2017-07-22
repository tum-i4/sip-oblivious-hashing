#!/bin/bash

INPUT_DEP_PATH=/usr/local/lib/
OH_PATH=/home/sip/protection/introspection-oblivious-hashing
OH_LIB=$OH_PATH/build/lib
bitcode=$1
hashvars=$2

#clang-3.9 -c -emit-llvm -W -Wall -Werror -DVERSION=\"1.0.1\" -o snake.bc snake.c

# compiling external libraries to bitcodes
clang++-3.9 $OH_PATH/assertions/asserts.cpp -std=c++0x -c -emit-llvm -o $OH_PATH/assertions/asserts.bc
clang-3.9 $OH_PATH/hashes/hash.c -c -emit-llvm -o $OH_PATH/hashes/hash.bc

# Running hash insertion pass
opt-3.9 -load $INPUT_DEP_PATH/libInputDependency.so -load  $OH_LIB/liboblivious-hashing.so $1 -oh-insert -num-hash $hashvars -o oh.bc
# Linking with external libraries
llvm-link-3.9 oh.bc $OH_PATH/hashes/hash.bc -o oh.bc
llvm-link-3.9 oh.bc $OH_PATH/assertions/asserts.bc -o oh.bc
exit 1

# precompute hashes
#clang++-3.9 -lncurses -lunwind-x86_64 -lunwind -rdynamic -std=c++0x oh.bc -o oh
llc-3.9 -filetype=obj oh.bc
g++ oh.o -o oh -std=c++0x -lm -lncurses -lssl -lcrypto
./oh
###rm out
#

# Running assertion insertion pass
opt-3.9 -load $INPUT_DEP_PATH/libInputDependency.so -load $OH_LIB/liboblivious-hashing.so oh.bc -insert-asserts -o protected.bc
# Compiling to final protected binary
#clang++-3.9 -lncurses -rdynamic -std=c++0x protected.bc -o protected
llc-3.9 -filetype=obj protected.bc
gcc protected.o -o protected -lm -lncurses -lssl -lcrypto
