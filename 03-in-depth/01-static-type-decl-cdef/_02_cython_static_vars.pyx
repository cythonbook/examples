def dummy_func():
    cdef int i
    cdef int j
    cdef float k

    j = 0
    i = j
    k = 12.0
    j = 2 * k
    assert i != j

def several_at_once():
    cdef int i, j, k
    cdef float price, margin
    #...

def optional_initial_value():
    cdef int i = 0
    cdef long int j = 0, k = 0
    cdef float price = 0.0, margin = 1.0
    #...
