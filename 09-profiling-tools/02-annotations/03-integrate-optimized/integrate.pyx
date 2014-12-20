cimport cython

@cython.cdivision(True)
cdef double c_integrate(double a, double b, double (*f)(double), int N=2000):

    cdef:
        int i
        double dx = (b-a)/N
        double s = 0.0

    for i in range(N):
        s += f(a+i*dx)
    return s * dx
