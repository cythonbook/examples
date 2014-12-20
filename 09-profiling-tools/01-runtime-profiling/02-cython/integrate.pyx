# cython: profile=True

# math.h `sin`, at compile time:
from libc.math cimport sin

# Pure-Python `sin`, at runtime:
# from math import sin

def sin2(x):
    return sin(x)**2

def integrate(double a, double b, f, int N=2000):
    cdef:
        int i
        double dx = (b-a)/N
        double s = 0.0
    for i in range(N):
        s += f(a+i*dx)
    return s * dx


# Original pure-python version.
# def integrate(a, b, f, N=2000):
    # dx = (b-a)/N
    # s = 0.0
    # for i in range(N):
        # s += f(a+i*dx)
    # return s * dx
