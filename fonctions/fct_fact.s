/*
uint64_t fact(uint64_t n)
{
    if (n <= 1) {
        return 1;
    } else {
        return n * fact(n - 1);
    }
}
*/

    .text
    .globl fact
    /* uint64_t fact(uint64_t n) */
/* DEBUT DU CONTEXTE
Fonction :
    fact : non feuille
Contexte :
    n : registre a0; pile *(sp+0)
    ra : pile *(sp+8)
FIN DU CONTEXTE */
fact:
    addi sp, sp, -16
    sd  ra, 8(sp)
    sd  a0, 0(sp)       /* on stock n dans la pile */

fact_fin_prologue:
    li  t2, 2
    blt a0, t2, fin

    add t1, a0, -1      /* t1 <- (n-1) */
    mv  a0, t1          /* a0 <- (n-1) */
    call fact           /* a0 = fact(a0) */

    ld  a1, 0(sp)       /* a1 <- n */
    call mult           /* a0 = a1 * (fact(a0)) */
    j  fact_debut_epilogue
fin: 
    li  t0, 1
    mv  a0, t0
fact_debut_epilogue:
    ld  ra, 8(sp)
    addi sp, sp, 16
    ret
