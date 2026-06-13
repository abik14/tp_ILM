/*
uint64_t taille_chaine(const char *chaine)
{
    uint64_t taille = 0;
    while (chaine[taille] != '\0') {
        taille++;
    }
    return taille;
}
*/
    .text
    .globl taille_chaine
/* uint64_t taille_chaine(const char *chaine) */
/* DEBUT DU CONTEXTE
Fonction :
    taille_chaine : feuille
Contexte :
    chaine : registre a0
    taille : registre t0
FIN DU CONTEXTE */

taille_chaine:
taille_chaine_fin_prologue:
    mv   t1, a0       /* t1 = chaine */
    li   t0, 0        /* t0 = taille */

boucle_while:
    lbu  t2, 0(t1)    
    beq  t2, x0, end
    addi t0, t0, 1
    addi t1, t1, 1
    j    boucle_while
end:
    mv   a0, t0       
taille_chaine_debut_epilogue:
    ret
