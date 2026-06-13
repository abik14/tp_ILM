/*****************************************
void *hash_delete(htable_t *h, const char *key)
{
    uint64_t index = hash_hash(key) % h->n;
    entry_t **e = &h->table[index];
    while (*e != NULL && strcmp(key, (*e)->key)) {
        entry_t *ne = *e;
        e = &ne->next;
    }
    entry_t *delete = *e;
    if (delete == NULL) {
        return NULL;
    }
    void *data = delete->data;
    *e = (*e)->next;
    free(delete);
    return data;
}
*****************************************/

/* DEBUT DU CONTEXTE
Fonction :
    hash_delete : non feuille
Contexte :
    h : registre s0
    key : registre s1
    index : registre t0
    e : registre s2
    delete : registre t1
    data : registre s3
FIN DU CONTEXTE */
    .globl hash_delete
    .type  hash_delete, @function
hash_delete:
    addi    sp, sp, -48         
    sd      ra, 0(sp) 
    sd      s0, 8(sp) 
    sd      s1, 16(sp)
    sd      s2, 24(sp)
    sd      s3, 32(sp)

hash_delete_fin_prologue:
    mv      s0, a0              # s0 = h
    mv      s1, a1              # s1 = key

    mv      a0, s1              # a0 = key
    call    hash_hash           # a0 = hash
    ld      t1, 8(s0)           # t1 = h->n
    remu    t0, a0, t1          # t0 = index

    # e = &h->table[index]
    ld      t2, 0(s0)           # t2 = h->table
    slli    t3, t0, 3           # t3 = index * 8
    add     t2, t2, t3          # t2 = &h->table[index]
    mv      s2, t2              # s2 = e

while:
    ld      t1, 0(s2)           # t1 = *e
    beqz    t1, loop_end
    mv      a0, s1              # a0 = key
    ld      a1, 8(t1)           # a1 = (*e)->key
    call    strcmp
    beqz    a0, loop_end
    mv      s2, t1              # next field offset = 0
    j       while

loop_end:
    ld      t1, 0(s2)           # t1 = delete = *e
    beqz    t1, return_null

    ld      s3, 16(t1)          # s3 = data = delete->data

    # *e = (*e)->next
    ld      t2, 0(t1)           # t2 = delete->next
    sd      t2, 0(s2)

    # free(delete)
    mv      a0, t1
    call    free

    mv      a0, s3              # return data
    j       hash_delete_debut_epilogue

return_null:
    li      a0, 0               # return NULL

hash_delete_debut_epilogue:
    ld      ra, 0(sp)
    ld      s0, 8(sp)
    ld      s1, 16(sp)
    ld      s2, 24(sp)
    ld      s3, 32(sp)
    addi    sp, sp, 48
    ret
    .size   hash_delete, .-hash_delete