def integrate(a, b, f):
    cdef:
        int i
        int N=2000
        float dx, s=0.0

    dx = (b-a)/N
    for i in range(N):
        s += f(a+i*dx)
    return s * dx
