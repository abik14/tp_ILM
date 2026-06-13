/*
uint64_t pgcd_baremetal(void)
{
    uint64_t i = 420;
    uint64_t j = 273;
    while (i != j) {
        if (i < j) {
            j = j - i;
        } else {
            i = i - j;
        }
    }
    return i;
}
*/
    .text
    .globl pgcd, entry
/*
  On propose de mettre les variables i et j respectivement dans les registres t0 et t1.

  La valeur de retour devra être mise dans le registre a0.
*/

/* DEBUT DU CONTEXTE
Fonction :
    pgcd : feuille
Contexte :
    i  : registre t0
    j  : registre t1
FIN DU CONTEXTE */
entry:
pgcd:
pgcd_fin_prologue:
    /* uint64_t i=420; */
    li   t0, 420
    /* uint64_t j=273; */
    li   t1, 273
    /* while (i != j) {  */
while:
    beq  t0, t1, fin_while /* Saut à fin si i == j */
    /* if (i < j) {  */
    sltu t2, t0, t1 /* Le registre t2 est utilisé pour stocker le résultat du test i < j */
    beqz t2, else /* pseudo-instruction, on aurait pu utiliser beq t2, zero, else */
    /* j = j - i;  */
    sub  t1, t1, t0
    j    fin_if
    /* } else {  */
else:
    /* i = i - j;  */
    sub  t0, t0, t1
    /*  }  */
fin_if:
    /*  }  */
    j    while
fin_while:
    /* return i; */
    mv   a0, t0 /* pseudo-instruction équivalente à add a0, t0, zero ou addi a0, t0, 0, ... */
pgcd_debut_epilogue:
    /* Pour ce premier exemple nous n'exécutons sur notre machine que ce simple programme,
    sans aucune bibliothèque, ni affichage, ni système d'exploitation.
    Pour terminer proprement, nous allons éteindre la machine virtuelle QEMU. */
eteindre_qemu:
    li a0,0x100000
    li a1,0x5555
    sw a1,0(a0)
    ret
