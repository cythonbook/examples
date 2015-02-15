# distutils: language=c++

cimport cython
cimport _algorithm

ctypedef fused long_or_double:
    cython.long
    cython.double

def min(long_or_double a, long_or_double b):
    return _algorithm.min(a, b)

def max(long_or_double a, long_or_double b):
    return _algorithm.max(a, b)
