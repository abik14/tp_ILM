#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>
#include <string.h>

/* Hashing dit externe, d'autres techniques existent */
typedef struct entry {
    struct entry *next;
	char *key;
	void *data;
} entry_t;

typedef struct htable {
	entry_t **table;
	uint64_t n; /* un nombre premier va bien */
} htable_t;

htable_t *create_htable(uint64_t n)
{
    htable_t *h = malloc(sizeof *h);
    h->n = n;
    h->table = calloc(n, sizeof *h->table);
    return h;
}

void delete_htable(htable_t *h)
{
    for (uint64_t index = 0; index < h->n; index++) {
        entry_t *p;
        for (entry_t *e = h->table[index]; e; e = p) {
            p = e->next;
            free(e->key);
            free(e);
        }
    }
    free(h->table);
    free(h);
}

/*
 * Partie à faire en assembleur riscv
 */
extern uint64_t hash_hash(const char *key);

void hash_insert(htable_t *h, char *key, void *data)
{
    uint64_t index = hash_hash(key) % h->n;
    entry_t *e = malloc(sizeof *e);
    e->next = h->table[index];
    e->key = strdup(key);
    e->data = data;
    h->table[index] = e;
}

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

void *hash_delete(htable_t *h, const char *key)
{
    uint64_t index = hash_hash(key) % h->n;
    entry_t **e = &h->table[index];
    while (*e != NULL && strcmp(key, (*e)->key)) {
        entry_t *ne = *e;
        e = &ne->next; 
    }
    entry_t *hash_delete = *e;
    if (hash_delete == NULL) {
        return NULL;
    }
    void *data = hash_delete->data;
    *e = (*e)->next;
    free(hash_delete);
    return data;
}

void dump(htable_t *h)
{
    for (uint64_t index = 0; index < h->n; index++) {
        printf("[%lu]- ", index);
        for (entry_t *e = h->table[index]; e; e = e->next) {
            printf("%p: %s%s", e, e->key, e->next ? ", " : "");
        }
        putchar('\n');
    }
}

static char *data[] = { "alpha", "bravo", "charlie", "delta",
    "echo", "foxtrot", "golf", "hotel", "india", "juliet",
    "kilo", "lima", "mike", "november", "oscar", "papa",
    "quebec", "romeo", "sierra", "tango", "uniform",
    "victor", "whisky", "x-ray", "yankee", "zulu"
};
uint64_t hash_c(const char *key)
{
    uint64_t hash = 5381;
    uint8_t c = *key;
    while ((c = *key++)) {
        hash = ((hash << 5) + hash) ^ c;
    }

    return hash;
}
int main(void)
{
    for(uint64_t i = 0; i < 26; i++) {
        uint64_t h = hash_hash(data[i]);
        uint64_t hc = hash_c(data[i]);
        printf("hash(\"%s\") = %lu / %lu(ref)\n", data[i], h, hc);
    }
    exit(EXIT_SUCCESS);
}
