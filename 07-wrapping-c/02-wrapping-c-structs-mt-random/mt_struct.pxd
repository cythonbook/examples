cdef extern from "mt19937ar-struct.h":
    ctypedef struct mt_state
    mt_state *make_mt(unsigned long s)
    void free_mt(mt_state *state)
    double genrand_real1(mt_state *state)
