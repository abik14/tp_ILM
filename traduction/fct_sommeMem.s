/*
uint64_t res;

void sommeMem(void)
{
    uint64_t i;
    res = 0;
    for (i = 1; i <= 10; i++) {
        res = res + i;
    }
}
*/

    .text
    .globl sommeMem, entry
/* DEBUT DU CONTEXTE
Fonction :
    sommeMem : feuille
Contexte :
    i : registre t0
    res : mémoire, section .data
FIN DU CONTEXTE */
entry:
sommeMem:
sommeMem_fin_prologue:
    li t0, 1          /* i = 1 */
    li t1, 11         /* max = 11 */
    la t3, res    
    sd x0, res, t3    /* t3: adresse de res */
for: 
    bge t0, t1, fin_for /* i >= max = 11 */
    ld t2, res      
    add t2, t2, t0    /* res = res + i */
    sd t2, res, t3 
    addi t0, t0, 1    /* i++ */
    j for
fin_for:
sommeMem_debut_epilogue:
    /* éteindre la machine virtuelle QEMU. */
eteindre_qemu:
    li a0,0x100000
    li a1,0x5555
    sw a1,0(a0)
    ret # pour l'infrastructure d'évaluation automatique

    .data
    .align 3
    .weak res
res:
    .quad 0
/* uint64_t res;
  La variable globale res étant définie dans ce fichier, il est nécessaire de
  la définir dans la section .data du programme assembleur.
  On utilisera l'attribut .weak (au lieu de .globl) pour éviter des erreurs 
  de linkage si res est déjà définie dans un autre fichier (par exemple decls.c).
*/


