
cdef extern from "_fib.h":
    unsigned long int _cfib "fib"(unsigned long int)

def cfib(unsigned long int n):
    return _cfib(n)

def fib(long n):
    '''Returns the nth Fibonacci number.'''
    cdef long long a=0, b=1, i
    for i in range(n):
        a, b = a + b, a
    return a
