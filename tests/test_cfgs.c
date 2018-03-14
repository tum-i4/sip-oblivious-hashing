#include <stdio.h>

//extern void assert(long long* hash, long long expected);
//extern void hash1(long long *hashVariable, long long value);

void test1(int i)
{
    printf("test1\n");
    int res = 0;
    //long long hash = 0;
    //hash1(&hash, res);
    if (i > 0) {
        res = 1;
        //hash1(&hash, res);
        //assert(&hash, 7000000000000);
        printf("positive\n");
    }
    res = -1;
    printf("end test1\n");
}

void test2(int i)
{
    int k = 0;
    if (i > 0) {
        k = 12;
        printf("positive test2\n");
    } else {
        ++k;
        printf("negative test2\n");
    }
    int res = k;
    printf("end test2\n");
}

/*
void test3(int i)
{
    if (i > 0) {
        if (i > 42) {
            print("positive 42");
        } else {
            print("positive non 42");
        }
        print("positive");
    }
    print("end");
}

void test4(int* n)
{
    int sum = 0;
    for (int i = 0; i < *n; ++i) {
        sum += i;
    }
}

void test5(int n)
{
    int sum = 0;
    int N = 42;
    for (int i = 0; i < N; ++i) {
        if (i < n) {
            --sum;
        }
        ++sum;
    }
    test4(&sum);
}
*/
int main(int argc, char* argv[])
{
    printf("main\n");
    test2(argc);
    int result = 0;
    if (argc > 2) {
        printf("argc branch\n");
        test1(argc);
        result = 12;
    }
    return 0;
}

