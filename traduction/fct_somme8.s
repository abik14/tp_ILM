/*
uint8_t res8=42; // La variable est initialisée à autre chose que la valeur finale attendue
// Et n'est pas mis à 0 pour s'assurer que c'est bien somme8 qui fait le travail.

uint8_t somme8(void)
{
    uint8_t i;
    res8 = 0;
    for (i = 1; i <= 30; i++) {
        res8 = res8 + i;
    }
    return res8;
}
*/

    .text
    .globl somme8, entry
/* DEBUT DU CONTEXTE
Fonction :
    somme8 : feuille
Contexte :
    i : registre t0
    res8 : mémoire, section .data
FIN DU CONTEXTE */
entry:
somme8:
somme8_fin_prologue:
    li  t0, 1
    la  t1, res8
    sb  x0, res8, t1
    li  t2, 30
for: 
    bgt t0, t2, end_for
    lbu t3, res8
    add t3, t3, t0
    sb  t3, res8, t1
    addi t0, t0, 1
    j for
end_for:
    lbu t3, res8
    mv  a0, t3
somme8_debut_epilogue:
    /* éteindre la machine virtuelle QEMU. */
eteindre_qemu:
    li a0,0x100000
    li a1,0x5555
    sw a1,0(a0)
    ret # pour l'infrastructure d'évaluation automatique

    .globl res8
    .section .data
/* uint8_t res8=42;
  La variable globale res8 étant définie dans ce fichier, il est nécessaire de
  la définir dans la section .data du programme assembleur.
*/
    .align 0
    .weak res8
res8:
    .quad 42