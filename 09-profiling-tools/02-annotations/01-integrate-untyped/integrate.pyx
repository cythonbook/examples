def integrate(a, b, f, N=2000):
    dx = (b-a)/N
    s = 0.0
    for i in range(N):
        s += f(a+i*dx)
    return s * dx
