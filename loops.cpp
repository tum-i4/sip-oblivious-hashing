#include <stdio.h>

int check() {
  return 10000 * 2 + 10;
}


int main() {
  int *store = new int[10];
  for (int i = 0; i < check(); i++) {
    if (i < check() / 10) 
      store[0]++;
    else
      store[i % 5]--;
    printf("%i", i);
    printf("%i\n", store[0]);
  }
}
