import julia
import numpy as np
from time import clock
import matplotlib.pyplot as plt

t1 = clock()
jl = julia.calc_julia(1000, (0.322 + 0.05j))
print "time:", clock() - t1

print "julia fraction:", julia.julia_fraction(jl)

plt.imshow(np.log(jl))
plt.show()
