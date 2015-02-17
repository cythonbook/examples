from cpython.array cimport array

def summer(double[:] mv):
    """Sums its argument's contents."""
    cdef double d, ss = 0.0
    for d in mv:
        ss += d
    return ss
