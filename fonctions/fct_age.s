/*
uint64_t age(uint64_t annee_naissance)
{
    uint64_t age;
    age = 2000 - annee_naissance;
    return age;
}
*/

    .text
    .globl age
    /* uint64_t age(uint64_t annee_naissance) */
/* DEBUT DU CONTEXTE
Fonction :
    age : feuille
Contexte : # contexte imposé
    annee_naissance  : registre a0
    age              : pile *(sp+0)  # de type uint64_t
FIN DU CONTEXTE */
age:
    addi sp, sp, -8
age_fin_prologue:
    li  t1, 2000
    sub t0, t1, a0
    sd  t0, (sp)
    ld  a0, (sp)
age_debut_epilogue:
    addi sp, sp, 8
    ret
