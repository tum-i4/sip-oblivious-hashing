
# Oblivious hashing
Latest updates can be found on the ACSAC branch.

# Citation
Please cite this tool as:
```
@inproceedings{Ahmadvand:2018:PIP:3274694.3274732,
 author = {Ahmadvand, Mohsen and Hayrapetyan, Anahit and Banescu, Sebastian and Pretschner, Alexander},
 title = {Practical Integrity Protection with Oblivious Hashing},
 booktitle = {Proceedings of the 34th Annual Computer Security Applications Conference},
 series = {ACSAC '18},
 year = {2018},
 isbn = {978-1-4503-6569-7},
 location = {San Juan, PR, USA},
 pages = {40--52},
 numpages = {13},
 url = {http://doi.acm.org/10.1145/3274694.3274732},
 doi = {10.1145/3274694.3274732},
 acmid = {3274732},
 publisher = {ACM},
 address = {New York, NY, USA},
 keywords = {Man-At-The-End, Oblivious hashing, Self-checking, Software protection, Tamper detection},
}
```


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



