#include <stdio.h>
#include <stdlib.h>
#include <execinfo.h>
#include <math.h>

#include <unordered_set>
#define DEBUG 1
#define DEBUG2 0


bool already_seen_placeholder(long long expected)
{
    static std::unordered_set<long long> placeholders;
    return !placeholders.insert(expected).second;
}

extern "C" {

void response() {
	printf("Response mechanism.\n");
	exit(777);
}

void do_assert(long long* hash, long long expected)
{
	//if(DEBUG)
	if(*hash != expected){
        printf("\tAssert: %lld==%lld\n", *hash, expected);
		void* callstack[128];
		int i, frames = backtrace(callstack, 128);
		char** strs = backtrace_symbols(callstack, frames);
	

		for (i = 0; i < frames; ++i) {
			printf("%s\n", strs[i]);
		}

		free(strs);

        //        printf("\tAssert: %lld==%lld\n", *hash, expected);
		response();
	}/*else {
		//print the last functioni before assert in the trace
		printf("%s\n",strs[1]);
	}*/
}

void assert(long long* hash, long long expected) {
    if (already_seen_placeholder(expected)) {
        return;
    }
    do_assert(hash, expected);
}

void oh_hash1(long long *hashVariable, long long value) {
	*hashVariable = *hashVariable + value;
	if(DEBUG2) printf("[h1] Hash=%lld, Value=%lld\n", *hashVariable, value);
}

void oh_hash2(long long *hashVariable, long long value) {
	*hashVariable = *hashVariable ^ value;
	if(DEBUG2) printf("[h2] Hash=%lld, Value=%lld\n", *hashVariable, value);
}

}
