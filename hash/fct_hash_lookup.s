/*****************************************
entry_t *hash_lookup(htable_t *h, const char *key)
{
    uint64_t index = hash_hash(key) % h->n;
    for (entry_t *e = h->table[index]; e; e = e->next) {
        if (!strcmp(key, e->key)) {
            return e;
        }
    }
    return NULL;
}
*****************************************/

/* DEBUT DU CONTEXTE
Fonction :
    hash_lookup : non feuille
Contexte :
    h : registre a0
    key : registre a1
    index : registre t0
    e : registre t1
FIN DU CONTEXTE */
    .globl hash_lookup
    .type  hash_lookup, @function
hash_lookup:
    addi    sp, sp, -32
    sd      ra, 0(sp)
    sd      a0, 8(sp)
    sd      a1, 16(sp)

hash_lookup_fin_prologue:
    ld      a0, 16(sp)
    call    hash_hash
 
    ld      t2, 8(sp)           # t2 = h
    ld      t3, 8(t2)           # t3 = h->n
    remu    t0, a0, t3

    ld      t4, 0(t2)           # t4 = h->table
    slli    t5, t0, 3           # t5 = index * 8
    add     t4, t4, t5          # t4 = &h->table[index]
    ld      t1, 0(t4)

while:
    beqz    t1, return_null
    sd      t1, 24(sp)
    ld      a0, 16(sp)
    ld      a1, 8(t1)
    call    strcmp
    beqz    a0, return_e
    ld      t1, 24(sp)
    ld      t1, 0(t1)
    j       while

return_e:
    ld      a0, 24(sp)
    j       hash_lookup_debut_epilogue

return_null:
    li      a0, 0

hash_lookup_debut_epilogue:
    ld      ra, 0(sp)
    addi    sp, sp, 32
    ret
    .size   hash_lookup, .-hash_lookup