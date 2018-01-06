#include <stdio.h>
#include <stdlib.h>
#include <execinfo.h>
#include <math.h>
#include <stdarg.h>

#define DEBUG 0
#define DEBUG2 0

void response() {
	printf("Response mechanism.\n");
	exit(1);
}

void assert(long long* hash, unsigned num, ...)
{
	if(DEBUG) printf("\tAssert: %lld==%lld\n", *hash, expected);
	void* callstack[128];
	int i, frames = backtrace(callstack, 128);
	char** strs = backtrace_symbols(callstack, frames);
	
    va_list arguments;
    for (unsigned i = 0; i < num; ++i) {
        if (*hash == va_arg(arguments, long long)) {
            return;
        }
    }
    va_end(arguments);
    printf("\tAssert: incorrect hash value %lld\n", *hash);
    for (i = 0; i < frames; ++i) {
        printf("%s\n", strs[i]);
    }
	free(strs);
    response();
}

void hash1(long long *hashVariable, long long value) {
	*hashVariable = *hashVariable + value;
	if(DEBUG2) printf("[h1] Hash=%lld, Value=%lld\n", *hashVariable, value);
}

void hash2(long long *hashVariable, long long value) {
	*hashVariable = *hashVariable ^ value;
	if(DEBUG2) printf("[h2] Hash=%lld, Value=%lld\n", *hashVariable, value);
}
