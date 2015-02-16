# distutils: language=c++
# distutils: sources=histogram.cpp
# distutils: include_dirs= .

from cython.operator cimport dereference as deref
from libcpp.vector cimport vector

from smart_ptr cimport shared_ptr

cdef extern from "histogram.h":
    shared_ptr[vector[int]] histogram(vector[int] data)

def hist_sum(args):
    cdef:
        shared_ptr[vector[int]] phist = histogram(args)
        vector[int] hist = deref(phist)
        double weighted_sum = 0.0
        int elt, n_total = 0

    print args

    for idx, elt in enumerate(hist):
        print idx, elt
        weighted_sum += idx * elt
        n_total += elt

    return weighted_sum / n_total
