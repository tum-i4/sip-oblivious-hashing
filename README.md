# Oblivious hashing

# To build the tool:
----------------------------
	mkdir build
	cd build
	cmake ../
	make
    
# Running first pass:
-------------------------
    clang++-3.9 -std=c++0x source.cpp -c -emit-llvm
    opt-3.9 -load /usr/local/lib/libInputDependency.so -load  $BUILD/lib/liboblivious-hashing.so source.bc -oh-insert -num-hash 1 -o out.bc
    llvm-link-3.9 out.bc $HASHES/hashes/hash.bc -o out.bc
    llvm-link-3.9 out.bc $ASSERTIONS/asserts.bc -o out.bc
    
# To precompute hashes:
-----------------------------------
	lli-3.9 out.bc [protected program input arguments]

# Run second pass:
---------------------------------------
    opt-3.9 -load /usr/local/lib/libInputDependency.so -load $BUILD/lib/liboblivious-hashing.so out.bc -insert-asserts -o protected.bc
    clang++-3.9 -rdynamic -std=c++0x protected.bc -o protected



