#include <stdio.h>
#include <stdlib.h>
#include <inttypes.h>

extern uint64_t age(uint64_t);

int main(void)
{
   uint64_t annee = 1982;
   printf("Né(e) en %" PRIu64 ", vous aviez donc %" PRIu64 " ans en l'an 2000 !\n", annee, age(annee));
   return 0;
}
