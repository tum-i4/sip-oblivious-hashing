clang++-3.9 -std=c++0x ../bubble_sort.cpp -c -emit-llvm
opt-3.9 -load /usr/local/lib/libInputDependency.so -load lib/libskeleton.so bubble_sort.bc -oh-insert -num-hash 1 -o out.bc
llvm-link-3.9 out.bc ../hashes/hash.bc -o out.bc
llvm-link-3.9 out.bc ../assertions/asserts.bc -o out.bc

clang++-3.9 -rdynamic -std=c++0x -stdlib=libc++ out.bc -o out
#dump hashes
./out 3
rm out

opt-3.9 -load /usr/local/lib/libInputDependency.so -load ../build/lib/libskeleton.so out.bc -insert-asserts -o protected.bc
clang++-3.9 -rdynamic -std=c++0x protected.bc -o protected

