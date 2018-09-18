# Oblivious hashing

# To build the tool:
----------------------------
	mkdir build
	cd build
	cmake ../
	make
    
# Running OH
Run run-oh-binary.sh script passing bitcode to protected and optionally command line arguments for the protected binary. 
For example to run protection on bubble_sort from tests run

	./run-oh-binary.sh bubble_sort.bc " 4"
	
where 4 is input to bubble_sort binary. 
run-oh-binary.sh script will apply both OH and Short Range OH protection on full bitcode, i.e. all functions will be considered sensitive and protected. The output of this script is protected binary named ```out_patched```, it also creates oh and and input dependency analysis statistics files - ```oh.stats``` and ```dependency.stats``` respectively. 
To run protected binary ```assertions/librtlib.so``` library should be preloaded with ```LD_PRELOAD```.    

# Necessary tools to build and run OH
In order to compile and use OH tool following tools need to be compiled and installed in your system.
Refer to each of those projects for compilation and installing.

    Input dependency Analizer - https://github.com/mr-ma/input-dependency-analyzer
    DG - https://github.com/tum-i22/dg
    self checksumming - https://github.com/mr-ma/self-checksumming

