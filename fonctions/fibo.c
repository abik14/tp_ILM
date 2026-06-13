#include <stdio.h>
#include <stdlib.h>
#include <inttypes.h>

extern uint64_t fibo(uint32_t);

int main()
{
   uint64_t n = 8;
   printf("Fibo(%" PRIu64 ") = %" PRIu64 "\n", n, fibo(n));
   return 0;
}
