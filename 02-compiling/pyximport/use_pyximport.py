import pyximport
pyximport.install()

import fib

print "fib.__file__", fib.__file__

print "fib.fib(90):", fib.fib(90)

print "fib.cfib(90):", fib.cfib(90)
