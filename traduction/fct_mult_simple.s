/*
// dans la mémoire globale et à allouer en langage d'assemblage
uint64_t x=7, y=8;
uint64_t res=42;

uint64_t mult_simple(void)
{
    res = 0;
    while (y != 0) {
        res = res + x;
        y--;
    }
    return res;
}
*/
    .text
    .globl mult_simple, entry
/* DEBUT DU CONTEXTE
Fonction :
    mult_simple : feuille
Contexte :
    x : mémoire, section .data
    y : mémoire, section .data
    res : mémoire, section .data
FIN DU CONTEXTE */
entry:
mult_simple:
mult_simple_fin_prologue:
    la  t0, x       
    la  t1, y
    la  t2, res
    sd  x0, res, t2
     
while:
    ld  t4, y
    beq t4, x0, fin_while
    ld  t3, x
    ld  t5, res
    add t5, t5, t3
    addi t4, t4, -1
    sd  t5, res, t2
    sd  t4, y, t1
    j   while
fin_while: 
    ld  t5, res
    mv  a0, t5
mult_simple_debut_epilogue:
    /* éteindre la machine virtuelle QEMU. */
eteindre_qemu:
    li a0,0x100000
    li a1,0x5555
    sw a1,0(a0)
    ret # pour l'infrastructure d'évaluation automatique


    .section .data
/* uint64_t x=7, y=8, res=42; 
On utilisera l'attribut .weak (au lieu de .globl) pour éviter des erreurs 
d'édition de lien si x, y ou res sont déjà définies dans un autre fichier (par exemple decls.c).
*/
    .align 3
    .weak x
x:
    .quad 7
    .weak y
y:  
    .quad 8
    .weak res
res:
    .quad 42
