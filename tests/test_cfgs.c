#include <stdio.h>

int g = 0;

// entry -> if.then - can process as nothing is hashed in if.then
// entry -> if.else can not process as k is used and is data indep
// entry -> if.end can process as no data indep 
void test2(int i, int j)
{
    int k = 0;
    k = j;
    if (i > 0) {
        k = 12;
    } else {
        ++k;
    }
    int res = k;
    printf("end test2\n");
}

int test1(int i, int j)
{
    int k = 32;
    int n = 0;
    if (k) {
        --n;
    }
    return n;
}

// entry -> if.then - can process
// entry -> if.end - can process
int main(int argc, char* argv[])
{
    printf("main\n");
    int result = 0;
    test2(argc, 0);
    if (argc > 2) {
        test1(21, 22);
        printf("argc branch\n");
        result = 12;
    }
    return 0;
}

