#!/bin/bash
make -C build/

if [ $# -eq 0 ]
  then
    echo "Bitcode file need to be supplied"
    exit 1
fi


INPUT_DEP_PATH=/usr/local/lib/
OH_PATH=/home/sip/sip-oblivious-hashing
OH_LIB=$OH_PATH/build/lib
bitcode=$1
assert_list=$2
input=$3

# compiling external libraries to bitcodes
clang++-3.9 $OH_PATH/assertions/asserts.cpp -fno-use-cxa-atexit -std=c++0x -c -emit-llvm -o $OH_PATH/assertions/asserts.bc
clang-3.9 $OH_PATH/hashes/hash.c -c -fno-use-cxa-atexit -emit-llvm -o $OH_PATH/hashes/hash.bc
clang++-3.9 $OH_PATH/assertions/logs.cpp -fno-use-cxa-atexit -std=c++0x -c -emit-llvm -o $OH_PATH/assertions/logs.bc

# Running hash insertion pass
if [ $# -eq 2 ] 
  then
    echo "Assert file list is supplied"
    opt-3.9 -load $INPUT_DEP_PATH/libInputDependency.so -load  $OH_LIB/liboblivious-hashing.so $bitcode -oh-insert -num-hash 1 -skip 'hash' -assert-functions $assert_list -o out.bc
else
    echo "No assert file is supplied.."
    opt-3.9 -load $INPUT_DEP_PATH/libInputDependency.so -load  $OH_LIB/liboblivious-hashing.so $bitcode -oh-insert -num-hash 1 -skip 'hash' -o out.bc
fi
# Linking with external libraries
llvm-link-3.9 out.bc $OH_PATH/hashes/hash.bc -o out.bc
llvm-link-3.9 out.bc $OH_PATH/assertions/asserts.bc -o out.bc
llvm-link-3.9 out.bc $OH_PATH/assertions/logs.bc -o out.bc

# intermediate precompute hashes
clang++-3.9 -lncurses -rdynamic -std=c++0x out.bc -o out
./out $input
###rm out
#

# Running assertion insertion pass
rm hashes_dumper.log
opt-3.9 -load $INPUT_DEP_PATH/libInputDependency.so -load $OH_LIB/liboblivious-hashing.so out.bc -insert-asserts -o protected.bc

# final hash computation
clang++-3.9 -lncurses -rdynamic -std=c++0x protected.bc -o protected
./protected $input


#Runnig assertion finalization pass
opt-3.9 -load $INPUT_DEP_PATH/libInputDependency.so -load $OH_LIB/liboblivious-hashing.so protected.bc -insert-asserts-finalize -o protected.bc
# Compiling to final protected binary
clang++-3.9 -lncurses -rdynamic -std=c++0x protected.bc -o protected
./protected $input


