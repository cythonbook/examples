
cdef extern from "boost/shared_ptr.hpp" namespace "boost":
    cdef cppclass shared_ptr[T]:
        shared_ptr()
        shared_ptr(T *p)
        shared_ptr(const shared_ptr&)
        long use_count()
        T operator*()
