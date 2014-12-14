from timeit import repeat
from subprocess import check_output

def timer(arg, niter, name, module):
    stmt = "%s(%s)" % (name, arg)
    setup = "from %s import %s" % (module, name)
    time = min(repeat(stmt=stmt, setup=setup, number=niter)) / float(niter) * 1e9
    return time


N = 10**6
pytime_0 = timer(0, N, name='fib', module='fib')
cytime_0 = timer(0, N, name='fib', module='cyfib')
cexttime_0 = timer(0, N, name='fib', module='cfib')
ctime_0 = float(check_output(('./cfib.x 0 %d' % N).split()))

py0speedup = 1.0
cy0speedup = pytime_0 / cytime_0
cext0speedup = pytime_0 / cexttime_0
c0speedup = pytime_0 / ctime_0

N = 10**5
pytime_90 = timer(90, N, name='fib', module='fib')
cytime_90 = timer(90, N, name='fib', module='cyfib')
cexttime_90 = timer(90, N, name='fib', module='cfib')
ctime_90 = float(check_output(('./cfib.x 90 %d' % N).split()))

py90speedup = 1.0
cy90speedup = pytime_90 / cytime_90
cext90speedup = pytime_90 / cexttime_90
c90speedup = pytime_90 / ctime_90

data_format =  "{:s},{:.0f},{:.1f},{:.0f},{:.1f}\n"

with open("fib.csv", 'w') as fh:
    fh.write("Version,fib(0) runtime [ns],speedup,fib(90) runtime [ns],speedup\n")
    fh.write(data_format.format("Python", pytime_0, py0speedup, pytime_90, py90speedup))
    fh.write(data_format.format("C extension", cexttime_0, cext0speedup, cexttime_90, cext90speedup))
    fh.write(data_format.format("Cython", cytime_0, cy0speedup, cytime_90, cy90speedup))
    fh.write(data_format.format("Pure C", ctime_0, c0speedup, ctime_90, c90speedup))
