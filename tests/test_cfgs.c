
extern void print(const char* );

void test1(int i)
{
    if (i > 0) {
        print("positive");
    }
    print("end");
}

void test2(int i)
{
    if (i > 0) {
        print("positive");
    } else {
        print("negative");
    }
    print("end");
}

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

void test4(int n)
{
    int sum = 0;
    for (int i = 0; i < n; ++i) {
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
}

int main()
{
    return 0;
}

