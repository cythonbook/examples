# The Computer Language Benchmarks Game
# http://benchmarksgame.alioth.debian.org/
#
# originally by Kevin Carson
# modified by Tupteq, Fredrik Johansson, and Daniel Nanz
# modified by Maciej Fijalkowski
# 2to3

from libc.math cimport pow, sqrt
import sys 

PI = 3.14159265358979323
SOLAR_MASS = 4 * PI * PI
DAYS_PER_YEAR = 365.24

cdef struct body_t:
    double x[3]
    double v[3]
    double m

DEF NBODIES = 5

BODIES = {
        'sun': ([0.0, 0.0, 0.0], [0.0, 0.0, 0.0], SOLAR_MASS),

        'jupiter': ([4.84143144246472090e+00,
            -1.16032004402742839e+00,
            -1.03622044471123109e-01],
            [1.66007664274403694e-03 * DAYS_PER_YEAR,
                7.69901118419740425e-03 * DAYS_PER_YEAR,
                -6.90460016972063023e-05 * DAYS_PER_YEAR],
            9.54791938424326609e-04 * SOLAR_MASS),

        'saturn': ([8.34336671824457987e+00,
            4.12479856412430479e+00,
            -4.03523417114321381e-01],
            [-2.76742510726862411e-03 * DAYS_PER_YEAR,
                4.99852801234917238e-03 * DAYS_PER_YEAR,
                2.30417297573763929e-05 * DAYS_PER_YEAR],
            2.85885980666130812e-04 * SOLAR_MASS),

        'uranus': ([1.28943695621391310e+01,
            -1.51111514016986312e+01,
            -2.23307578892655734e-01],
            [2.96460137564761618e-03 * DAYS_PER_YEAR,
                2.37847173959480950e-03 * DAYS_PER_YEAR,
                -2.96589568540237556e-05 * DAYS_PER_YEAR],
            4.36624404335156298e-05 * SOLAR_MASS),

        'neptune': ([1.53796971148509165e+01,
            -2.59193146099879641e+01,
            1.79258772950371181e-01],
            [2.68067772490389322e-03 * DAYS_PER_YEAR,
                1.62824170038242295e-03 * DAYS_PER_YEAR,
                -9.51592254519715870e-05 * DAYS_PER_YEAR],
            5.15138902046611451e-05 * SOLAR_MASS) 
        }

def combinations(l):
    result = []
    for x in range(len(l) - 1):
        ls = l[x+1:]
        for y in ls:
            result.append((l[x],y))
    return result

cdef void make_cbodies(list bodies, body_t *cbodies, int num_cbodies):
    cdef body_t *cbody
    for i, body in enumerate(bodies):
        if i >= num_cbodies:
            break
        (x, v, m) = body
        cbody = &cbodies[i]
        cbody.x[0], cbody.x[1], cbody.x[2] = x
        cbody.v[0], cbody.v[1], cbody.v[2] = v
        cbodies[i].m = m

cdef list make_pybodies(body_t *cbodies, int num_cbodies):
    pybodies = []
    for i in range(num_cbodies):
        x = [cbodies[i].x[0], cbodies[i].x[1], cbodies[i].x[2]]
        v = [cbodies[i].v[0], cbodies[i].v[1], cbodies[i].v[2]]
        pybodies.append((x, v, cbodies[i].m))
    return pybodies


def advance(double dt, int n, bodies):
    # Note that this does not take a `pairs` argument, and *returns* a new
    # `bodies` list.  This is slightly different from the original pure-Python
    # version of `advance`.

    cdef:
        int i, ii, jj
        double dx, dy, dz, mag, b1m, b2m, ds
        body_t *body1
        body_t *body2
        body_t cbodies[NBODIES]

    make_cbodies(bodies, cbodies, NBODIES)

    for i in range(n):
        for ii in range(NBODIES-1):
            body1 = &cbodies[ii]
            for jj in range(ii+1, NBODIES):
                body2 = &cbodies[jj]
                dx = body1.x[0] - body2.x[0]
                dy = body1.x[1] - body2.x[1]
                dz = body1.x[2] - body2.x[2]
                ds = dx * dx + dy * dy + dz * dz
                mag = dt / (ds * sqrt(ds))
                b1m = body1.m * mag
                b2m = body2.m * mag
                body1.v[0] -= dx * b2m
                body1.v[1] -= dy * b2m
                body1.v[2] -= dz * b2m
                body2.v[0] += dx * b1m
                body2.v[1] += dy * b1m
                body2.v[2] += dz * b1m
        for ii in range(NBODIES):
            body2 = &cbodies[ii]
            body2.x[0] += dt * body2.v[0]
            body2.x[1] += dt * body2.v[1]
            body2.x[2] += dt * body2.v[2]

    return make_pybodies(cbodies, NBODIES)


def report_energy(bodies):
    # Note that this takes just a `bodies` list, and computes `pairs`
    # internally, which is a slight modification from the original pure-Python
    # version of `report_energy`.

    e = 0.0

    pairs = combinations(bodies)

    for (((x1, y1, z1), v1, m1),
            ((x2, y2, z2), v2, m2)) in pairs:
        dx = x1 - x2
        dy = y1 - y2
        dz = z1 - z2
        e -= (m1 * m2) / ((dx * dx + dy * dy + dz * dz) ** 0.5)
    for (r, [vx, vy, vz], m) in bodies:
        e += m * (vx * vx + vy * vy + vz * vz) / 2.
    print("%.9f" % e)


def offset_momentum(ref, bodies):

    px = py = pz = 0.0

    for (r, [vx, vy, vz], m) in bodies:
        px -= vx * m
        py -= vy * m
        pz -= vz * m
    (r, v, m) = ref
    v[0] = px / m
    v[1] = py / m
    v[2] = pz / m


def main(n, bodies=BODIES, ref='sun'):
    system = list(bodies.values())
    offset_momentum(bodies[ref], system)
    report_energy(system)
    system = advance(0.01, n, system)
    report_energy(system)
