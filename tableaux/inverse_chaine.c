#include <stdio.h>
#include <inttypes.h>
#include <stdlib.h>
#include <string.h>

extern void inverse_chaine(char *, uint64_t);

static uint64_t taille_chaine(const char *chaine)
{
    uint64_t taille = 0;
    while (chaine[taille] != '\0'){
        taille++;
    }
    return taille;
}

int main(void)
{
   char *chaines[] = { "Ensimag", "", "a", "ab", "abc", "abcd", "abcde", NULL };
   for (int64_t i = 0; chaines[i]; i++) {
      printf("Chaine : \"%s\"\n", chaines[i]);
      uint64_t taille = taille_chaine(chaines[i]);
      char *inv_chaine = malloc(taille + 1);
      strcpy(inv_chaine, chaines[i]);
      inverse_chaine(inv_chaine, taille);
      printf("Chaine inversee : \"%s\"\n\n", inv_chaine);
   }
   return 0;
}
