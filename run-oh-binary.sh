#!/bin/bash
make -C build/
if [ $? -eq 0 ]; then
 echo 'OK Compile'
else
 echo 'FAIL Transform'
 exit    
fi 


if [ $# -eq 0 ]
  then
    echo "Bitcode file need to be supplied"
    exit 1
fi

UTILS_PATH=/home/sip/self-checksumming/build/lib/libUtils.so
INPUT_DEP_PATH=/usr/local/lib/
OH_PATH=/home/sip/sip-oblivious-hashing
OH_LIB=$OH_PATH/build/lib
bitcode=$1
assert_list=$2
input=$3

# compiling external libraries to bitcodes
#clang++-3.9 $OH_PATH/assertions/asserts.cpp -fno-use-cxa-atexit -std=c++0x -c -emit-llvm -o $OH_PATH/assertions/asserts.bc
#clang-3.9 $OH_PATH/hashes/hash.c -c -fno-use-cxa-atexit -emit-llvm -o $OH_PATH/hashes/hash.bc
#clang++-3.9 $OH_PATH/assertions/logs.cpp -fno-use-cxa-atexit -std=c++0x -c -emit-llvm -o $OH_PATH/assertions/logs.bc
clang-3.9 $OH_PATH/assertions/response.c -c -fno-use-cxa-atexit -emit-llvm -o $OH_PATH/assertions/response.bc

# Running hash insertion pass
if [ $# -eq 2 ] 
  then
    echo "Assert file list is supplied"
    opt-3.9 -load $INPUT_DEP_PATH/libInputDependency.so -load $UTILS_PATH -load  $OH_LIB/liboblivious-hashing.so $bitcode -oh-insert -num-hash 1 -skip 'hash' -dump-oh-stat="oh.stats" -assert-functions $assert_list -o out.bc
else
    echo "No assert file is supplied.."
    opt-3.9 -load $INPUT_DEP_PATH/libInputDependency.so -load $UTILS_PATH -load $OH_LIB/liboblivious-hashing.so $bitcode -oh-insert -num-hash 1 -skip 'hash' -dump-oh-stat="oh.stats" -o out.bc
fi

if [ $? -eq 0 ]; then
            echo 'OK Transform'
else
            echo 'FAIL Transform'
            exit    
fi 

llc-3.9 out.bc
gcc -c -rdynamic out.s -o out.o
gcc -g -rdynamic -c $OH_PATH/assertions/response.c -o response.o
gcc -g -rdynamic out.o response.o -o out


# Linking with external libraries
#llvm-link-3.9 out.bc $OH_PATH/assertions/response.bc -o out.bc

# intermediate precompute hashes
#clang++-3.9 -g -lncurses -rdynamic -std=c++0x out.bc -o out


#Patch using GDB
python $OH_PATH/patcher/patchAsserts.py out out_patched 
echo 'Generated bianry is out_patched ...'
