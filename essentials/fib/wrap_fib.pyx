cdef extern from "cfib.h":
    unsigned long _fib "fib"(unsigned long n)

def fib(n):
    ''' Returns the nth Fibonacci number.'''
    return _fib(n)
