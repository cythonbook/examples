def declaring_c_pointers():
    cdef int *p_int
    cdef float** pp_float = NULL
    #...

    cdef int *a, *b

    # cdef int *a, b # not recommended, error prone!

from cython.operator cimport dereference as deref

def reference_dereference():
    cdef double golden_ratio
    cdef double *p_double

    p_double = &golden_ratio
    p_double[0] = 1.618

    print golden_ratio
    # => 1.618

    print p_double[0]
    # => 1.618

    print deref(p_double)
    # => 1.618

cdef struct st_t:
    int a

def struct_access():
    cdef st_t ss = st_t(a=0)
    cdef st_t *p_st = &ss
    cdef int a_doubled = p_st.a + p_st.a
