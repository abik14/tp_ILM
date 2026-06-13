#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <inttypes.h>

#define TAILLE_MAX 150
#define STR_M(s) #s
#define STR(s) STR_M(s)

extern void tri_min(int64_t tab[], uint64_t taille);

static void afficher_tab(int64_t tab[], uint64_t taille)
{
   for (uint64_t i = 0; i < taille; i++) {
      printf("%" PRId64 " ", tab[i]);
   }
   printf("\n");
}

int comp(const void *a, const void *b)
{
   return *(int64_t *) a - *(int64_t *) b;
}

int main(void)
{
   uint64_t taille = 23;
   printf("Taille du tableau voulue: %" PRIu64 "\n", taille);
   if (taille > TAILLE_MAX) {
      printf("Erreur, la taille du tableau doit être inférieure à " STR(TAILLE_MAX) " !\n");
      exit(1);
   }

   int64_t *tab = (int64_t *)malloc(taille * sizeof(int64_t));
   if (tab == NULL) {
      printf("Erreur, allocation de tab impossible !\n");
      exit(1);
   }

   srandom(666); /* Diabolique, n'est-il pas ? */

   for (uint64_t i = 0; i < taille; i++) {
      tab[i] = (random() % 666) - 333;
   }

   if (taille < 20) {
      printf("Tableau initial : ");
      afficher_tab(tab, taille);
   }
   /*Réservation de tableau pour le tri de référence et le tri optimisé */
   int64_t *ref = malloc(taille * sizeof(int64_t));
   if (ref == NULL) {
      printf("Erreur, allocation de ref impossible !\n");
      exit(1);
   }
   memcpy(ref, tab, sizeof(int64_t) * taille);

   /* Tri de référence */
   qsort(ref, taille, sizeof(int64_t), comp);

   /* Tri avec la version systématique */
   tri_min(tab, taille);
   if (taille < 20) {
      printf("Tableau trie par recherche du minimum : ");
      afficher_tab(tab, taille);
   }
   if (memcmp(ref, tab, sizeof(int64_t)* taille) == 0) {
      printf("Tri par recherche du minimum conforme\n");
   } else {
      printf("Erreur : le tri par recherche du minimum n'est pas correct !\n");
      exit(1);
   }
   return 0;
}
