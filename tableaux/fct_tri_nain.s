/*
void tri_nain(int64_t tab[], uint64_t taille)
{
    uint64_t i = 0;
    while(i < taille - 1) {
        if (tab[i] > tab[i+1]) {
            int64_t tmp = tab[i];
            tab[i] = tab[i+1];
            tab[i + 1] = tmp;
            if (i > 0) {
                i = i - 1;
            }
        } else {
            i = i + 1;
        }
    }
}
*/

    .text
/*  void tri_nain(int64_t tab[], uint64_t taille) */
    .globl tri_nain
/* DEBUT DU CONTEXTE
Fonction :
    tri_nain : feuille
Contexte :
    tab : registre a0
    taille : registre a1
    i : registre t0
    tmp : registre t1
FIN DU CONTEXTE */
tri_nain:
tri_nain_fin_prologue:
    li      t0, 0                # i = 0
    addi    t5, a1, -1            # t5 = taille - 1
boucle:
    bge     t0, t5, fin_boucle    # while (i < taille-1)

    # Lecture de tab[i]
    slli    t2, t0, 3
    add     t2, a0, t2
    ld      t3, 0(t2)             # t3 = tab[i]

    # Lecture de tab[i+1]
    addi    t4, t0, 1
    slli    t4, t4, 3
    add     t4, a0, t4
    ld      t6, 0(t4)             # t6 = tab[i+1]

    ble     t3, t6, else          # if (tab[i] > tab[i+1])

    # Écriture dans tab[i] (on recalcule l'adresse)
    slli    t2, t0, 3
    add     t2, a0, t2
    sd      t6, 0(t2)             # tab[i] = tab[i+1]

    # Écriture dans tab[i+1] (on recalcule l'adresse)
    addi    t4, t0, 1
    slli    t4, t4, 3
    add     t4, a0, t4
    sd      t3, 0(t4)             # tab[i+1] = ancien tab[i]

    beq     t0, x0, boucle        # if (i == 0) ne pas décrémenter
    addi    t0, t0, -1            # i = i - 1
    j       boucle

else:
    addi    t0, t0, 1              # i = i + 1
    j       boucle

fin_boucle:
tri_nain_debut_epilogue:
    ret