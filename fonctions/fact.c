#include <stdio.h>
#include <stdlib.h>
#include <inttypes.h>

extern uint64_t fact(uint64_t);

int main()
{
   uint64_t n = 7;
   printf("Fact(%" PRIu64 ") = %" PRIu64 "\n", n, fact(n));
   return 0;
}
