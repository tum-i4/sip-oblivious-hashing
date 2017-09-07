#include <stdio.h>
#include <stdint.h>
/*
void hash3(long long *hashVar, char* value, int size) {
  for (int i = 0; i < size; i++)
      printf("%d\n", value[i]);
}
*/

// PJW Hash
void hash2(uint64_t *hashVar, uint64_t value) {
  //*hashVar += value;
  uint8_t *key = (uint8_t *)&value;
  uint64_t high = 0;
  for (int i = 0; i < sizeof(value); i++) {
    *hashVar = (*hashVar << 4) + key[i];
    if ((high = *hashVar & 0xF000000000000000))
      *hashVar ^= high >> 56;
    *hashVar &= ~high;
  }
  printf("hash2:%lu\n",value);
  //printf("H2: %lu\n", *hashVar);
}

//CRC Variant
void hash1(uint64_t *hashVar, uint64_t value) {
  uint8_t *key= (uint8_t *)&value;
  uint64_t highorder = 0;
  for (int i = 0; i < sizeof(value); i++) {
    highorder = *hashVar & 0xF800000000000000;
    *hashVar = *hashVar << 5;
    *hashVar ^= highorder >> 59;
    *hashVar ^= key[i];
  }
  printf("hash1:%lu\n",value);
  //printf("H1: %lu\n", *hashVar);
}
