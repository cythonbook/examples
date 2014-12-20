# The original, non-parallelized version.

from cython cimport boundscheck, wraparound

import numpy as np

cdef inline double norm2(double complex z) nogil:
    return z.real * z.real + z.imag * z.imag


cdef int escape(double complex z,
                double complex c,
                double z_max,
                int n_max) nogil:

    cdef:
        int i = 0
        double z_max2 = z_max * z_max

    while norm2(z) < z_max2 and i < n_max:
        z = z * z + c
        i += 1

    return i


@boundscheck(False)
@wraparound(False)
def calc_julia(int resolution, double complex c,
               double bound=1.5, double z_max=4.0, int n_max=1000):

    cdef:
        double step = 2.0 * bound / resolution
        int i, j
        double complex z
        double real, imag
        int[:, ::1] counts

    counts = np.zeros((resolution+1, resolution+1), dtype=np.int32)

    for i in range(resolution + 1):
        real = -bound + i * step
        for j in range(resolution + 1):
            imag = -bound + j * step
            z = real + imag * 1j
            counts[i,j] = escape(z, c, z_max, n_max)

    return np.asarray(counts)


@boundscheck(False)
@wraparound(False)
def julia_fraction(int[:,::1] counts, int maxval=1000):
    cdef:
        int total = 0
        int i, j, N, M
    N = counts.shape[0]; M = counts.shape[1]

    for i in range(N):
        for j in range(M):
            if counts[i,j] == maxval:
                total += 1
    return total / float(counts.size)
