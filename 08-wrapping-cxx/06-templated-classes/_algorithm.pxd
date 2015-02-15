cdef extern from "<algorithm>" namespace "std":
    const T max[T](T a, T b)
    const T min[T](T a, T b)
    void sort[T](T first, T last)
    void sort[T,C](T first, T last, C comp)
    void rotate[iter](iter first, iter middle, iter last)
