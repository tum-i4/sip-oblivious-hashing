#include <stdio.h>
#include <stdlib.h>
#include <execinfo.h>
#include <math.h>
#define DEBUG 1
#define DEBUG2 0

void response() {
	printf("Response mechanism.\n");
//	exit(1);
}

void assert(long long hash, long long expected) {
	//if(DEBUG)
    printf("\tAssert: %lld==%lld\n", hash, expected);
	if(hash != expected){
		void* callstack[128];
		int i, frames = backtrace(callstack, 128);
		char** strs = backtrace_symbols(callstack, frames);
	

		for (i = 0; i < frames; ++i) {
			printf("%s\n", strs[i]);
		}

		free(strs);
		response();
	}/*else {
		//print the last functioni before assert in the trace
		printf("%s\n",strs[1]);
	}*/

}

void hash1(long long *hashVariable, long long value) {
	*hashVariable = *hashVariable + value;
	if(DEBUG2) printf("[h1] Hash=%lld, Value=%lld\n", *hashVariable, value);
}

void hash2(long long *hashVariable, long long value) {
	*hashVariable = *hashVariable ^ value;
	if(DEBUG2) printf("[h2] Hash=%lld, Value=%lld\n", *hashVariable, value);
}
