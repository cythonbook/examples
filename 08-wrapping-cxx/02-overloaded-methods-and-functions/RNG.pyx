# distutils: language = c++
# distutils: sources = mt19937.cpp

from cython.operator cimport dereference as deref
from cpython.array cimport array

cdef extern from "mt19937.h" namespace "mtrandom":
    unsigned int N
    cdef cppclass MT_RNG:
        MT_RNG()
        MT_RNG(unsigned long s)
        MT_RNG(unsigned long init_key[], int key_length)
        void init_genrand(unsigned long s)
        unsigned long genrand_int32()
        double genrand_real1()
        double operator()()


cdef class RNG:

    cdef MT_RNG *_thisptr

    def __cinit__(self, seed_or_state):
        cdef array state_arr
        if isinstance(seed_or_state, int):
            self._thisptr = new MT_RNG(seed_or_state)
        else:
            state_arr = array("L", seed_or_state)
            self._thisptr = new MT_RNG(state_arr.data.as_ulongs, len(state_arr))
        if self._thisptr == NULL:
            raise MemoryError()

    def __dealloc__(self):
        if self._thisptr != NULL:
            del self._thisptr

    cpdef unsigned long randint(self):
        return self._thisptr.genrand_int32()

    cpdef double rand(self):
        return self._thisptr.genrand_real1()

    def __call__(self):
        return deref(self._thisptr)()
