from distutils.core import setup
from Cython.Build import cythonize

setup(name="RNG",
      ext_modules=cythonize("RNG.pyx"))
