cdef extern from "mt19937ar.h":
    void init_genrand(unsigned long s)
    double genrand_real1()


