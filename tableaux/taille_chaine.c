#include <stdio.h>
#include <inttypes.h>
#include <stdlib.h>
#include <string.h>

extern uint64_t taille_chaine(const char *);

int main(void)
{
   char *chaines[] = { "Ensimag", "", "a", "ab", "abc", "abcd", "abcde", NULL };
   for (int64_t i = 0; chaines[i]; i++) {
      printf("Chaine : \"%s\"\n", chaines[i]);
      uint64_t taille = taille_chaine(chaines[i]);
      printf("Taille : %" PRIu64 "\n\n", taille);
   }
   return 0;
}
