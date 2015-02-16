from distutils.core import setup
from Cython.Build import cythonize

setup(name="hist_sum",
      ext_modules=cythonize("hist_sum.pyx"))


