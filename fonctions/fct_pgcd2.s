/*
uint64_t pgcd2(uint64_t a, uint64_t b)
{
    while (a != b) {
        if (a < b) {
            b = b - a;
        } else {
            a = a - b;
        }
    }
    return a;
}

*/
    .text
    .globl pgcd2
    /* uint64_t pgcd2(uint64_t a, uint64_t b) */
/* DEBUT DU CONTEXTE
  Fonction :
    pgcd2 : feuille   # => pas besoin de réserver d'espace dans la pile
  Contexte :
    a  : registre a0
    b  : registre a1
FIN DU CONTEXTE */
pgcd2:
pgcd2_fin_prologue:
    /* while (a != b) {  */
while:
    beq  a0, a1, fin /* Saut à fin si a==b */
    /* if (a < b) {  */
    sltu t0, a0, a1 /* Le registre t0 est utilisé pour stocker le résultat du test a<b */
    beqz t0, else
    /* b = b - a;  */
    sub  a1, a1, a0
    j    fin_if
    /* } else {  */
else:
    /* a = a - b;  */
    sub  a0, a0, a1
    /*  }  */
fin_if:
    /*  }  */
    j    while
    /* return a; */
fin:
    /* Par convention, le registre a0 (x10) contient la valeur de retour.
       Nos calculs mettant à jour a0, ce registre contient bien la valeur du pgcd.
       Par convention encore, l'adresse de retour dans la fonction appelante est
       stockée dans le registre ra (x1) */
pgcd2_debut_epilogue:
    ret
