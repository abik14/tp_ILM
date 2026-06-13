#pragma once

#include <stddef.h>

__attribute__((noreturn)) void abort(void);
#define EXIT_FAILURE 1
#define EXIT_SUCCESS 0
__attribute__((noreturn)) void exit(int status);

void* malloc(size_t size);
void* calloc(size_t n_elements, size_t element_size);
void* memalign(size_t alignment, size_t size);
void free(void* ptr);
long int strtol(const char *nptr, char **endptr, int base);

/* Added for the ILM course */
typedef int (*__compar_fn_t)(const void *, const void *);
void qsort (void *array, size_t count, size_t size, __compar_fn_t compare);
#define RAND_MAX (2<<15)-1
int random(void);
void srandom(unsigned seed);
