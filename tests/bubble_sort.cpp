#include <cstdio>
#include <cstdlib>

void sort(int n, int array[])
{
    printf("start sort\n");
    for (unsigned i = 0; i < n; ++i) {
        unsigned j = 0;
        while (j < n - 1) {
            if (array[j] > array[j + 1]) {
                int tmp = array[j];
                array[j] = array[j + 1];
                array[j + 1] = tmp;
            }
            ++j;
        }
    }
    printf("print results\n");
    for (unsigned i = 0; i < n; ++i) {
        printf("%d ", array[i]);
    }
    printf("\n");
}

double doubleStuff(int n, double b)
{
    double s = 0;
    for (int i = 0; i < n; i++) {
        s += b * i;
    }
    return s / 2;
}

int main(int argc, char* argv[])
{
    int SIZE = 7;
    int size = SIZE;
    if (argc != 2) {
        printf("wrong number of arguments. Expects number of elements to sort\n");
    } else {
        size = atoi(argv[1]);
    }

    // get minimum
    if (SIZE < size) {
        size = SIZE;
    }
    int array[] = {42, 78, 54, 12, 7, 1, 0};

    // sorts first size elements of array
    sort(size, array);
    doubleStuff(5, 7);
    doubleStuff(5, 7);
    return 0;
}
