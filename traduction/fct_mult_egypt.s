/*
uint64_t x=5, y=16;

uint64_t mult_egypt(void)
{
    uint64_t res = 0;
    while (y != 0) {
        if (y % 2 == 1) {
            res = res + x;
        }
        x = x << 1 ;
        y = y >> 1;
    }
    return res;
}
*/
    .text
    .globl mult_egypt, entry
/* Attention, res est une variable locale que l'on mettra dans t0 */
/* DEBUT DU CONTEXTE
Fonction :
    mult_egypt : feuille
Contexte :
    x : mémoire, section .data
    y : mémoire, section .data
    res : registre t0
FIN DU CONTEXTE */
entry:
mult_egypt:
mult_egypt_fin_prologue:
    la  t1, x       
    la  t2, y
    li  t0, 0     
while:
    ld  t4, y
    beq t4, x0, fin_while
    andi t4, t4, 1
    beq t4, x0, if_end
    ld  t5, x
    add t0, t0, t5
if_end:
    ld  t5, x
    ld  t4, y
    slli t5, t5, 1
    srli t4, t4, 1
    sd  t4, y, t2
    sd  t5, x, t1 
    j   while
fin_while: 
    mv  a0, t0
mult_egypt_debut_epilogue:
    /* éteindre la machine virtuelle QEMU. */
eteindre_qemu:
    li a0,0x100000
    li a1,0x5555
    sw a1,0(a0)
    ret # pour l'infrastructure d'évaluation automatique


    .section .data
/* uint64_t x=5, y=16; */
/* On utilisera l'attribut .weak (au lieu de .globl) pour éviter des erreurs 
d'édition de lien si x ou y sont déjà définies dans un autre fichier */

    .align 
    .weak x
x:
    .quad 5
    .weak y
y:  
    .quad 16
