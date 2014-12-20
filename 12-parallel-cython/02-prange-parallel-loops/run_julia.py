import julia
import numpy as np
import matplotlib.pyplot as plt

jl = julia.calc_julia(1000, (0.322 + 0.05j))
print julia.julia_fraction(jl)

plt.imshow(np.log(jl))
plt.show()
