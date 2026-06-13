/*
void tri_nain(int64_t tab[], uint64_t taille)
{
    uint64_t i = 0;
    while(i < taille - 1) {
        if (tab[i] > tab[i+1]) {
            int64_t tmp = tab[i];
            tab[i] = tab[i+1];
            tab[i + 1] = tmp;
            if (i > 0) {
                i = i - 1;
            }
        } else {
            i = i + 1;
        }
    }
}
*/

    .text
    .globl tri_nain_superopt
/* Version encore plus optimisée sans rien respecter (tout se perd ma bonne dame !).

Optimisations effectuées:
  - Partage des lectures mémoires et des calculs d'adresses
  - Calcul de taille - 1 en dehors de la boucle
  - À compléter avec vos autres optimisations

DEBUT DU CONTEXTE
Fonction :
    tri_nain_superopt : feuille
Contexte :
#   À compléter pour vous, mais laissez tout en commentaire (après '#'), sauf les paramètres
FIN DU CONTEXTE */
tri_nain_superopt:
tri_nain_superopt_fin_prologue:
tri_nain_superopt_debut_epilogue:
    ret
