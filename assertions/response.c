#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#define DEBUG 1
#define DEBUG2 0

void response() {
	printf("Response mechanism.\n");
	exit(1);
}

void assert(long long* hash, long long expected) {
	if(DEBUG) printf("\tAssert: %lld==%lld\n", *hash, expected);
	if(*hash != expected){
		response();
	}
}

void hash1(long long *hashVariable, long long value) {
	*hashVariable = *hashVariable + value;
	if(DEBUG2) printf("[h1] Hash=%lld, Value=%lld\n", *hashVariable, value);
}

void hash2(long long *hashVariable, long long value) {
	*hashVariable = *hashVariable ^ value;
	if(DEBUG2) printf("[h2] Hash=%lld, Value=%lld\n", *hashVariable, value);
}
