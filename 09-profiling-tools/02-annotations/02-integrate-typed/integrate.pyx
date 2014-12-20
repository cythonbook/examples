def integrate(double a, double b, f, int N=2000):

    cdef:
        int i
        double dx = (b-a)/N
        double s = 0.0

    for i in range(N):
        s += f(a+i*dx)
    return s * dx
