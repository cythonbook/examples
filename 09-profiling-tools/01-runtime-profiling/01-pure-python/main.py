from integrate import integrate
from math import pi, sin

def sin2(x):
    return sin(x)**2

def main():
    a, b = 0.0, 2.0 * pi
    return integrate(a, b, sin2, N=400000)

if __name__ == '__main__':
    import cProfile
    cProfile.run('main()', sort='time')
