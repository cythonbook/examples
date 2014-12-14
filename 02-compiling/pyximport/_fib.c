#include "_fib.h"

unsigned long int fib(unsigned long int n)
{
    unsigned long int a, b, tmp, i;
    a = 0; b = 1;
    for (i=0; i<n; ++i) {
        tmp = a; a += b; b = tmp;
    }
    return a;
}
