#include <stdio.h>
#include <stdlib.h>
#include <inttypes.h>

extern uint64_t fact_papl(uint64_t);

// La fonction erreur_fact n'est pas 'static' car elle est appelée depuis fact_papl.
void erreur_fact(uint64_t n)
{
   printf("Fact(%" PRIu64 ") ne tient pas sur 64 bits !\n", n);
   // la fonction exit arrete proprement le programme
   exit(1);
}

int main()
{
   uint64_t n = 40;
   printf("Fact(%" PRIu64 ") = %" PRIu64 "\n", n, fact_papl(n));
   return 0;
}

