# distutils: language=c++

cimport _algorithm

cdef extern from "<vector>" namespace "std":

    cdef cppclass vector[T]:
        vector() except +
        vector(vector&) except +
        vector(size_t) except +
        vector(size_t, T&) except +
        T& operator[](size_t)
        void clear()
        void push_back(T&)

        cppclass iterator:
            T& operator*()
            iterator operator++()
            iterator operator--()
            iterator operator+(size_t)
            iterator operator-(size_t)
            bint operator==(iterator)
            bint operator!=(iterator)
            bint operator<(iterator)
            bint operator>(iterator)
            bint operator<=(iterator)
            bint operator>=(iterator)

        vector.iterator begin()
        vector.iterator end()


def wrapper_func(elts):
    cdef vector[int] v
    for elt in elts:
        v.push_back(elt)
    # ...

def wrapper_func_heap(elts):
    cdef vector[int] *v = new vector[int]()
    # ...

ctypedef vector[void*].iterator vvit

def rotate_list(list ll, int rot):
    cdef vector[void*] vv
    for elt in ll:
        vv.push_back(<void*>elt)
    if rot < -len(ll) or rot >= len(ll):
        raise IndexError()
    rot = (rot + len(ll)) % len(ll)
    _algorithm.rotate[vvit](vv.begin(), vv.begin()+rot, vv.end())
    return [<object>o for o in vv]
