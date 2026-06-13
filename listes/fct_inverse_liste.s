/*
void inverse_liste(struct cellule_t **l)
{
   struct cellule_t *res, *suiv;
   res = NULL;
   while (*l != NULL) {
       suiv = (*l)->suiv;
       (*l)->suiv = res;
       res = *l;
       *l = suiv;
   }
   *l = res;
}
*/
    .text
    .globl inverse_liste
/* void inverse_liste(struct cellule_t **l) */
/* DEBUT DU CONTEXTE
Fonction :
    inverse_liste : feuille
Contexte :
    l    : registre a0
    res  : registre t0
    suiv : registre t1
    ptr_courant : registre t2
FIN DU CONTEXTE */
inverse_liste:
inverse_liste_fin_prologue:
    li t0, 0                    # res = NULL
    
while_loop:
    ld t2, 0(a0)                # t2 = *l
    beqz t2, end_while          # if (*l == NULL)

    ld t1, 8(t2)                # t1 = (*l)->suiv 
    sd t0, 8(t2)                # (*l)->suiv = res

    mv t0, t2                   # res = *l 
    sd t1, 0(a0)                # *l = suiv
    j while_loop
end_while:
    sd t0, 0(a0)                # *l = res
inverse_liste_debut_epilogue:
    ret
