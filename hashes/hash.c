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
    if (value == 17) {
        printf("H2 BBBB: %lu %lu\n", value, *hashVar);
    }
  //*hashVar += value;
  uint8_t *key = (uint8_t *)&value;
  uint64_t high = 0;
  for (int i = 0; i < sizeof(value); i++) {
    *hashVar = (*hashVar << 4) + key[i];
    if ((high = *hashVar & 0xF000000000000000))
      *hashVar ^= high >> 56;
    *hashVar &= ~high;
  }
    if (value == 17) {
        printf("H2: %lu %lu\n", value, *hashVar);
    }
  //printf("H2: %lu %lu\n", value, *hashVar);
}

//CRC Variant
void hash1(uint64_t *hashVar, uint64_t value) {
    if (value == 17) {
        printf("H1 BBBB: %lu %lu \n", value, *hashVar);
    }
  uint8_t *key= (uint8_t *)&value;
  uint64_t highorder = 0;
  for (int i = 0; i < sizeof(value); i++) {
    highorder = *hashVar & 0xF800000000000000;
    *hashVar = *hashVar << 5;
    *hashVar ^= highorder >> 59;
    *hashVar ^= key[i];
  }
  if (value == 17) {
        printf("H1: %lu %lu\n", value, *hashVar);
    }
  //printf("H1: %lu %lu\n", value, *hashVar);
}

void reset(uint64_t* variable)
{
    *variable = 0;
}


void print(uint64_t* variable)
{
    printf("KUKUUUU %lu\n", *variable);
}


/*
int main()
{
    uint64_t hash = 0;
    int i = 17;
    hash2(&hash, i);
    int j = 0;
    hash2(&hash, j);
//
    printf("%lu\n", hash);
    return 0;
}
*/
