#include <stdio.h>
#include <stdlib.h>
#include <inttypes.h>

// Déclaration de la fonction mult définie dans fct_mult.s
extern uint64_t mult(uint64_t a, uint64_t x);
// Déclaration de la fonction affine définie dans fct_affine.s
extern uint64_t affine(uint64_t a, uint64_t b, uint64_t x);

static uint64_t affine_c(uint64_t a, uint64_t b, uint64_t x)
{
   return mult(x, a) + b;
}

int main()
{
   uint64_t a, b, x;
   a = 2;
   b = 3;
   x = 4;
   uint64_t res_as = affine(a, b, x);
   printf("affine(%" PRIu64 ",%" PRIu64 ",%" PRIu64 ") calculé en assembleur: %" PRIu64 " et en C: %" PRIu64 "\n", a, b, x, res_as, affine_c(a, b, x));
   return 0;
}
