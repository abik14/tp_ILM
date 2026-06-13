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
 * Hash function
 * Due à D. Bernstein, étonnament bonne pour sa simplicité
 * key ne doit pas être nulle lors de l'appel à cette fonction
 */
uint64_t hash_hash(const char *key)
{
    uint64_t hash = 5381;
    uint64_t c;
    while (c = *key++) {
        hash = ((hash << 5) + hash) ^ c;
    }

    return hash;
}

void hash_insert(htable_t *h, char *key, void *data)
{
    uint64_t index = hash_hash(key) % h->n;
    entry_t *e = malloc(sizeof *e);
    e->next = h->table[index];
    e->key = strdup(key);
    e->data = data;
    h->table[index] = e;
}

/*
 * Partie à faire en assembleur riscv
 */
extern entry_t *hash_lookup(htable_t *h, const char *key);

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

int main(void)
{
    htable_t *h = create_htable(31);

    for (uint64_t i = 0; i < 24; i++) {
        hash_insert(h, data[i], (void *)i);
    }
    for (size_t i = 22; i < 26; i++) {
        entry_t *ep = hash_lookup(h, data[i]);
        printf("%9.9s -> %9.9s:%ld\n", data[i],
                ep ? ep->key : "(null)",
                ep ? (uint64_t)(ep->data) : 0);
    }
    exit(EXIT_SUCCESS);
}

