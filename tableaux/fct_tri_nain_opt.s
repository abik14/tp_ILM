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
    .globl tri_nain_opt
/* Version du tri optimisée sans respecter la contrainte de la traduction
   systématique pour les accès mémoire (et le calcul de leurs adresses)
   Complétez le contexte ci-dessous en indiquant les registres qui contiendront
   des variables temporaires.  */
   /* DEBUT DU CONTEXTE
Fonction :
    tri_nain_opt : feuille
Contexte :
    tab : registre a0
    taille : registre a1
    i : registre t0
    tmp : registre t1
FIN DU CONTEXTE */
tri_nain_opt:
tri_nain_opt_fin_prologue:
    li  t0, 0
    addi t5, a1, -1
boucle:
    bge t0, t5, fin_boucle

    slli t2, t0, 3
    add  t2, a0, t2
    ld  t3, 0(t2)

    addi t4, t0, 1
    slli t4, t4, 3
    add t4, a0, t4
    ld  t6, 0(t4)

    ble t3, t6, else
    mv  t1, t3
    sd  t6, 0(t2)
    sd  t1, 0(t4)

    beq t0, x0, boucle
    addi t0, t0, -1
    j boucle
else:
    addi t0, t0, 1
    j boucle

fin_boucle:
tri_nain_opt_debut_epilogue:
    ret
