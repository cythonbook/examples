# This version uses a cimport statement with the mt_struct.pxd file.
cimport mt_struct

# Using cimport allows cleaner separation between declaring the C interface to
# Cython and wrapping that interface, which is what this cdef class does.

cdef class MT:
    cdef mt_struct.mt_state *_thisptr

    def __cinit__(self, unsigned long s):
        self._thisptr = mt_struct.make_mt(s)
        if self._thisptr == NULL:
            raise MemoryError()

    def __dealloc__(self):
        mt_struct.free_mt(self._thisptr)

    cpdef double rand(self):
        return mt_struct.genrand_real1(self._thisptr)
