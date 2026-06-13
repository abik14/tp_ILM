/*
uint64_t x=5, y=16;

uint64_t mult_native(void)
{
    return x*y;
}
*/
    .text
    .globl mult_native, entry
/* DEBUT DU CONTEXTE
Fonction :
    mult_native : feuille
Contexte :
    x : mémoire, section .data
    y : mémoire, section .data
FIN DU CONTEXTE */
entry:
mult_native:
mult_native_fin_prologue:
    la t0, x
    la t1, y
    ld t2, x
    ld t3, y
    mul t4, t3, t2
    mv a0, t4
mult_native_debut_epilogue:
    /* éteindre la machine virtuelle QEMU. */
eteindre_qemu:
    li a0,0x100000
    li a1,0x5555
    sw a1,0(a0)
    ret # pour l'infrastructure d'évaluation automatique


    .section .data
/* uint64_t x=5, y=16; */
/*On utilisera l'attribut .weak (au lieu de .globl) pour éviter des erreurs 
d'édition de lien si x ou y sont déjà définies dans un autre fichier (par exemple decls.c).*/
    .align 3
    .weak x
x:
    .quad 5
    .weak y
y:
    .quad 16
