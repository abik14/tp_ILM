#include <stdio.h>
#include <inttypes.h>

struct structure_t {
   int64_t entier;
   char *ptr;
};

extern void affichage(struct structure_t);
extern void modification(uint64_t, char *, struct structure_t *);

void affiche(uint64_t entier, char *ptr)
{
   printf("entier = %" PRId64 ", ptr = 0x%" PRIx64 "\n", entier, (uint64_t) ptr);
}

int main(void)
{
   struct structure_t s = {-1, (char *)0xBADC0FFE};
   affichage(s);
   modification(5, (char *) 0xDEADC0DE, &s);
   affichage(s);
   return 0;
}
