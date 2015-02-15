# distutils: language=c++

from libcpp.vector cimport vector

cdef extern from "<algorithm>" namespace "std":
    void std_sort "std::sort" [iter](iter first, iter last)

def sort_list(list ll):
    cdef vector[int] vv = ll
    std_sort[vector[int].iterator](vv.begin(), vv.end())
    return vv
