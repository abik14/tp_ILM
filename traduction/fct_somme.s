/*
uint64_t somme(void)
{
    uint64_t i;
    uint64_t res = 0;
    for (i = 1; i <= 10; i++) {
        res = res + i;
    }
    return res;
}
*/
    .text
    .globl somme, entry
/* DEBUT DU CONTEXTE
Fonction :
    somme : feuille
Contexte :
    i : registre t0
    res : registre t1
FIN DU CONTEXTE */
entry:
somme:
somme_fin_prologue:
    li t0, 1 /*i=1*/
    li t1, 0 /*res=0*/
    li t2, 11 /*max=11*/
for: 
    bge t0, t2, fin_for /*i >= max=11 */
    add t1, t1, t0
    addi t0, t0, 1
    j for
fin_for:
    mv a0, t1
somme_debut_epilogue:
    /* éteindre la machine virtuelle QEMU. */
eteindre_qemu:
    li a0,0x100000
    li a1,0x5555
    sw a1,0(a0)
    ret
