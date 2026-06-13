/*
uint64_t affine(uint64_t a, uint64_t b, uint64_t x)
{
   return mult(x, a) + b;
}
*/

    .text
    .globl affine
    /* uint64_t affine(uint64_t a, uint64_t b, uint64_t x) */
/* DEBUT DU CONTEXTE
Fonction :
    affine : non feuille
Contexte :
    a : registre a0; pile *(sp+0)
    b : registre a1; pile *(sp+8)
    x : registre a2; pile *(sp+16)
    ra : pile *(sp+24)
FIN DU CONTEXTE */
affine:
    addi sp, sp, -32
    sd  ra, 24(sp)
    sd  a0, 0(sp)   /* a */
    sd  a1, 8(sp)   /* b  */
    sd  a2, 16(sp)   /* x */

affine_fin_prologue:
    ld a0, 16(sp)
    ld a1, 0(sp)
    call mult       /* a0 = mult(x,a) */
    ld  t0, 8(sp)
    add a0, a0, t0
    
affine_debut_epilogue:
    ld  ra, 24(sp)
    addi sp, sp, 32
    ret
