# The Computer Language Benchmarks Game
# http://benchmarksgame.alioth.debian.org/
#
# Contributed by Sebastien Loisel
# Fixed by Isaac Gouy
# Sped up by Josh Goldfoot
# Dirtily sped up by Simon Descarpentries
# Sped up by Joseph LaFata

from array import array
from math import sqrt

from cython cimport cdivision
from cython cimport boundscheck, wraparound
from cpython.array cimport array

@cdivision(True)
cdef inline double A(int i, int j):
    return 1.0 / (((i + j) * (i + j + 1) >> 1) + i + 1)

@boundscheck(False)
@wraparound(False)
cdef void A_times_u(double[::1] u, double[::1] v):
    cdef int i, j, u_len = len(u)
    cdef double partial_sum

    for i in range(u_len):
        partial_sum = 0
        for j in range(u_len):
            partial_sum += A(i, j) * u[j]
        v[i] = partial_sum


@boundscheck(False)
@wraparound(False)
cdef void At_times_u(double[::1] u, double[::1] v):
    cdef int i, j, u_len = len(u)
    cdef double partial_sum

    for i in range(u_len):
        partial_sum = 0
        for j in range(u_len):
            partial_sum += A(j, i) * u[j]
        v[i] = partial_sum


def B_times_u(u, out, tmp):
    A_times_u(u, tmp)
    At_times_u(tmp, out)


def spectral_norm(n):
    u = array("d", [1.0] * n)
    v = array("d", [0.0] * n)
    tmp = array("d", [0.0] * n)

    for _ in range(10):
        B_times_u(u, v, tmp)
        B_times_u(v, u, tmp)

    vBv = vv = 0

    for ue, ve in zip(u, v):
        vBv += ue * ve
        vv  += ve * ve

    return sqrt(vBv / vv)
