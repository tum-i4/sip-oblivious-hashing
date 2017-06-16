#include <stdio.h>

void hash3(long long *hashVar, char* value, int size) {
  for (int i = 0; i < size; i++)
      printf("%d\n", value[i]);
}
void hash2(long *hashVar, long value) {
  printf("in: %ld\n", value);
  *hashVar += value;
  printf("var: %ld\n", *hashVar);
}
void hash1() {
  printf("FUNCTION\n");
}
