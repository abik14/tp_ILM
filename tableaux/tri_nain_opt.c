#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <inttypes.h>

#define TAILLE 2500
#define STR_M(s) #s
#define STR(s) STR_M(s)

int64_t tab[TAILLE];
int64_t ref[TAILLE];

extern void tri_nain_opt(int64_t[], uint64_t);

static void afficher_tab(int64_t tab[], uint64_t taille)
{
   for (uint64_t i = 0; i < taille; i++) {
      printf("%" PRId64 " ", tab[i]);
   }
   printf("\n");
}

static void init_tabs(int64_t tab[], int64_t ref[], uint64_t taille)
{
   for (uint64_t i = 0; i < taille; i++) {
      tab[i] = (random() % 19) - 9;
   }
   memcpy(ref, tab, sizeof(int64_t) * taille);
}

int comp(const void *a, const void *b)
{
   return (int)(*(int64_t *)a - *(int64_t *)b);
}

int main(void)
{
   uint64_t taille = 45;
   if (taille > TAILLE) {
      printf("La taille est trop grande, test annulé.\n");
      exit(0);
   }
   printf("Test sur un tableau de taille %" PRIu64 "\n", taille);

   srandom(0xbaffe);
   init_tabs(tab, ref, taille);

   tri_nain_opt(tab, taille);

   if (taille < 26) {
      printf("Tableau initial : ");
      afficher_tab(ref, taille);
      printf("Tableau trie par le nain : ");
      afficher_tab(tab, taille);
   } else {
      printf("Le tableau a une taille > 25, il ne sera pas affiché.\n");
   }

   qsort(ref, taille, sizeof(int64_t), comp);

   if (memcmp(ref, tab, sizeof(int64_t) * taille) != 0) {
      printf("Erreur : le nain a mal trie un tableau (sale bete !).\n");
      exit(1);
   }
   printf("Le tableau est trié, le nain a bien fait son travail.\n");
   return 0;
}
