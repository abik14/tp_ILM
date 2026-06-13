/*
void tri_min(int64_t tab[], uint64_t taille)
{
    uint64_t i, j, ix_min;
    int64_t tmp;
    for (i = 0; i < taille - 1; i++) {
        for (ix_min = i, j = i + 1; j < taille; j++) {
            if (tab[j] < tab[ix_min]) {
                ix_min = j;
            }
        }
        tmp = tab[i];
        tab[i] = tab[ix_min];
        tab[ix_min] = tmp;
    }
}
*/
    .text
    .globl tri_min
/* void tri_min(int64_t tab[], uint64_t taille) */
/* DEBUT DU CONTEXTE
Fonction :
    tri_min : feuille 
Contexte :
    tab : registre a0
    taille : registre a1
    i : registre t0
    j : registre t1
    ix_min : registre t2
    tmp : registre t3
FIN DU CONTEXTE */
tri_min:
tri_min_fin_prologue:
    li  t0, 0              /* i = 0 */
    
boucle_i_for:
    addi t6, a1, -1        /* t6 = taille - 1 */
    bge t0, t6, end_i      
    
    mv  t2, t0             /* ix_min = i */
    addi t1, t0, 1         /* j = i + 1 */
    
boucle_j_for:
    bge t1, a1, end_j      
    
    slli t6, t1, 3         /* t6 = j * 8 (byte offset) */
    add  t6, a0, t6        /* address of tab[j] */
    ld   t4, 0(t6)         /* t4 = tab[j] */
    
    slli t5, t2, 3         /* t5 = ix_min * 8 (byte offset) */
    add  t5, a0, t5        /* address of tab[ix_min] */
    ld   t5, 0(t5)         /* t5 = tab[ix_min] */
    
    bge  t4, t5, sinon     /* if tab[j] >= tab[ix_min], skip */
    mv   t2, t1            /* ix_min = j */
    
sinon:
    addi t1, t1, 1         /* j++ */
    j    boucle_j_for

end_j:
    slli t6, t0, 3         /* t6 = i * 8 */
    add  t6, a0, t6        /* address of tab[i] */
    ld   t3, 0(t6)         /* tmp = tab[i] */
    
    slli t5, t2, 3         /* t5 = ix_min * 8 */
    add  t5, a0, t5        /* address of tab[ix_min] */
    ld   t4, 0(t5)         /* t4 = tab[ix_min] */
    
    sd   t4, 0(t6)         /* tab[i] = tab[ix_min] */
    sd   t3, 0(t5)         /* tab[ix_min] = tmp */
    
    addi t0, t0, 1         /* i++ */
    j    boucle_i_for

end_i:
tri_min_debut_epilogue:
    ret