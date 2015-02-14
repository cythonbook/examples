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

def make_random_list(unsigned long seed, unsigned int len):
    cdef list randlist = [0] * len
    cdef MT_RNG rng  # calls default ctor.
    cdef unsigned int i
    rng.init_genrand(seed)
    for i in range(len):
        randlist[i] = rng.genrand_int32()
    return randlist
