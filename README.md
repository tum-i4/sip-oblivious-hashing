# Running protection 
The recommended way to compile and run our protection is to use Docker container. 

Docker container
--------------------------------------------------
Build a docker image using the provided [DockerFile](https://github.com/tum-i22/sip-oblivious-hashing/tree/acsac/docker).
Run docker container with the following parameters:
```docker run -v /sys/fs/cgroup:/sys/fs/cgroup:rw --security-opt seccomp=unconfined {IMAGEID/IMAGENAME}```


Run experiments
--------------------------------------------------
Visit [```sip-eval```](https://github.com/mr-ma/sip-eval/tree/acsac) project to evaluate OH+SROH and SC protection on with our dataset. 

Manual setup 
---------------------------------
sip-oblivious-hashing dependes on the following projects
[```input-dependency-analyzer```](https://github.com/tum-i22/input-dependency-analyzer)

[```self-checksumming```](https://github.com/tum-i22/self-checksumming)

[```dg```](https://github.com/tum-i22/dg)

To compile and install these projects follow instructions in each of them.

Protection Scripts
--------------------------------
OH+SROH protection can be applied by running the script ```run-oh-binary.sh```.

```./run-oh-binary.sh {program.bc} {input}```

where ```program.bc``` is the bitcode of a program to protect and ```input``` in input to the protected binary when running it in postpatching phases.

In order to successfully run this script make sure to have input-dependency-analyzer and dg projects compiled and installed locally. self-checksumming should be in the home directory of the docker - /home/sip/.
If the libraries for these projects reside in other locations, corresponding paths in run-oh-binary.sh script need to be updated. 


Running OH+SROH instrumentation
------------------------------------------------
To run OH+SROH instrumentation

```opt -load $INPUT_DEP_PATH/libInputDependency.so -load $DG_PATH/libLLVMdg.so -load $SC_PATH/libUtils.so -load $OH_LIB/liboblivious-hashing.so -load $INPUT_DEP_PATH/libTransforms.so ${bitcode} -strip-debug -unreachableblockelim -globaldce -goto-unsafe -lib-config={lib-config} -oh-insert -short-range-oh -protect-data-dep-loops -num-hash 1 -skip 'hash' -dump-oh-stat="oh.stats" -o instrument.bc```

Where INPUT_DEP_PATH, DG_PATH and SC_PATH are directories where libraries for input dependency analyzer, dg and self-checksumming reside.
```bitcode``` is the bitcode to instrument. ```lib-config``` is the extenal libraries configuration file to be used by input dependency analyzer, it is optional.
The number of hash variables to be used by OH can be configured by using command line argument ```num-hash```. 
Short range OH can be disabled if cmd line argument ```-short-range-oh``` is skipped. If ```-protect-data-dep-loops``` is not set data dependent loops won't be covered by OH+SROH.

Running Post patching
------------------------------------
To manually run postpatching the postpatching manually first compile the instrumented binary from the previous step to an executable. Link it with the response file.
```llc instrumented.bc
g++ -std=c++0x -c -rdynamic out.s -o instrumented.o
g++ -fPIC -std=c++11 -g -rdynamic -c ${OH_PATH}/assertions/response.cpp -o ${OH_PATH}/assertions/oh_rtlib.o
LIB_FILES+=( "${OH_PATH}/assertions/oh_rtlib.o" )
g++ -std=c++11 -g -rdynamic -Wall -fPIC -shared -Wl,-soname,${OH_PATH}/assertions/libsrtlib.so -o "${OH_PATH}/assertions/librtlib.so" -lncurses -lm -lssl -lcrypto -pthread ${LIB_FILES[@]}
g++ -std=c++11 -g -rdynamic instrumented.o -o instrumented -L${OH_PATH}/assertions/ -lrtlib -lncurses -lm -lssl -lcrypto -pthread
```

All the commands can be found in the run-oh-binary script.
The output is instrumented executable. To patch OH+SROH expected hash values run the patcher

```export LD_PRELOAD="$SC_PATH/hook/build/libminm.so ${OH_PATH}/assertions/librtlib.so"
cmd_args=" ${input}"
python $OH_PATH/patcher/patchAsserts.py -b instrumented -n protected -s oh.stats -d False -g "$cmd_args" -p "$OH_PATH/assertions/gdb_script_for_do_assert.txt"
   ```
