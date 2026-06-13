/*
uint64_t fact_papl(uint64_t n)
{
    if (n <= 1) {
        return 1;
    } else {
        uint128_t tmp = (uint128_t)n*fact_papl(n-1);
        if ((tmp >> 64) > 0)
            erreur_fact(n);
        return (uint64_t)tmp;
    }
}
*/

    .text
    .globl fact_papl
    /* uint64_t fact_papl(uint64_t n) */
/* DEBUT DU CONTEXTE
Fonction :
    fact_papl : non feuille
Contexte :
    n : registre a0; pile *(sp+0)
    tmp : pile *(sp+8)
    ra : pile *(sp+24)
FIN DU CONTEXTE */
fact_papl:
    addi sp, sp, -32
    sd   a0, 0(sp)
    sd   ra, 24(sp)
fact_papl_fin_prologue:
    li      t0, 1
    ble     a0, t0, if1       # if (n <= 1) goto base

    ld      t1, 0(sp)         # t1 = n
    addi    a0, t1, -1        # a0 = n-1
    call    fact_papl         # a0 = fact(n-1)

    ld      t1, 0(sp)         # reload n (t1 is caller-saved)
    mul     t2, t1, a0        # t2 = low 64 bits
    mulhu   t3, t1, a0        # t3 = high 64 bits

    bnez    t3, if2
    mv      a0, t2
    j       fact_papl_debut_epilogue

if2:
    ld      a0, 0(sp)
    call    erreur_fact
    li      a0, 1

if1:
    li      a0, 1

fact_papl_debut_epilogue:
    ld      ra, 24(sp)
    addi    sp, sp, 32
    ret

    .size fact_papl, .-fact_papl