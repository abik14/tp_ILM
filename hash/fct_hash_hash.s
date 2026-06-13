/*
 * Hash function
 * Due à D. J. Bernstein, étonnamment bonne pour sa simplicité
 * key ne doit pas être nulle lors de l'appel à cette fonction
 */
/*****************************************
uint64_t hash_hash(const char *key)
{
    uint64_t hash = 5381;
    uint8_t c = *key;
    while ((c = *key++)) {
        hash = ((hash << 5) + hash) ^ c;
    }

    return hash;
}
*****************************************/

/* DEBUT DU CONTEXTE
Fonction :
    hash_hash : feuille
Contexte :
    key : registre a0
    hash : registre t0
    c : registre t1
FIN DU CONTEXTE */

    .text
    .globl hash_hash
    .type  hash_hash, @function
hash_hash:
hash_hash_fin_prologue:
    li      t0, 5381

while:
    lbu     t1, 0(a0)
    addi    a0, a0, 1
    beq     t1, x0, fin_hash
    slli    t2, t0, 5
    add     t2, t2, t0
    xor     t0, t2, t1
    j       while

fin_hash:
    mv      a0, t0              
end_hash:
hash_hash_debut_epilogue:
    ret
    .size   hash_hash, .-hash_hash
