/*****************************************
void hash_insert(htable_t *h, char *key, void *data)
{
    uint64_t index = hash_hash(key) % h->n;
    entry_t *e = malloc(sizeof *e);
    e->next = h->table[index];
    e->key = strdup(key);
    e->data = data;
    h->table[index] = e;
}
*****************************************/

/* DEBUT DU CONTEXTE
Fonction :
    nom_de_fonction : feuille ou non feuille
Contexte :
    À compléter
FIN DU CONTEXTE */
    .globl hash_insert
    .type  hash_insert, @function
hash_insert:
hash_insert_fin_prologue:
hash_insert_debut_epilogue:
    ret
    .size   hash_insert, .-hash_insert
