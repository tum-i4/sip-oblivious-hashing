#!/bin/bash
set -e

protected=protected.bc
protected_log=protected_log.bc
protected_obj=protected_gcc.o

TEST_DATA_PATH=~/dataset/inputs
INPUT_DEP_PATH=/usr/local/lib/
OH_LIB=build/lib
bitcode=$1
hashvars=$2
testfile=$3
ispiped=$4

#clang-3.9 -c -emit-llvm -W -Wall -Werror -DVERSION=\"1.0.1\" -o snake.bc snake.c

# compiling external libraries to bitcodes
clang++-3.9 assertions/asserts.cpp -std=c++0x -c -emit-llvm -o assertions/asserts.bc
clang++-3.9 assertions/logs.cpp -std=c++0x -c -emit-llvm -o assertions/logs.bc
clang-3.9 hashes/hash.c -c -emit-llvm -o hashes/hash.bc

# Running hash insertion pass
opt-3.9 -load $INPUT_DEP_PATH/libInputDependency.so -load  $OH_LIB/liboblivious-hashing.so $bitcode -oh-insert -num-hash $hashvars -o $protected
# Linking with external libraries
cp $protected $protected_log
llvm-link-3.9 $protected_log hashes/hash.bc -o $protected_log
llvm-link-3.9 $protected_log ~/controlflow-integrity/checkers/checker.bc -o $protected_log
llvm-link-3.9 $protected_log assertions/logs.bc -o $protected_log
llvm-link-3.9 $protected hashes/hash.bc -o $protected
llvm-link-3.9 $protected assertions/asserts.bc -o $protected

# precompute hashes
#clang++-3.9 -lncurses -lunwind-x86_64 -lunwind -rdynamic -std=c++0x oh.bc -o oh
llc-3.9 -filetype=obj $protected_log -o $protected_obj
g++ $protected_obj -o protected_gcc -std=c++0x -lm -lncurses -lunwind-x86_64 -lunwind
#./protected_gcc
if [ -z $ispiped ]; then
  python3 $TEST_DATA_PATH/ptypipe.py $testfile ./protected_gcc
else
  ./protected_gcc $testfile
fi
#exit 1
rm $protected_obj protected_gcc

# Running assertion insertion pass
opt-3.9 -load $INPUT_DEP_PATH/libInputDependency.so -load $OH_LIB/liboblivious-hashing.so $protected -insert-asserts -o $protected
# Compiling to final protected binary
#clang++-3.9 -lncurses -rdynamic -std=c++0x protected.bc -o protected
#llc-3.9 -filetype=obj $protected -o $protected_obj
#g++ $protected_obj -o protected_gcc -std=c++0x -lm -lncurses -lssl -lcrypto
