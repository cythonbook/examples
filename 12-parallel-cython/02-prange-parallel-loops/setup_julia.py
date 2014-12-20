from distutils.core import setup
from Cython.Build import cythonize

setup(name="julia",
      ext_modules=cythonize("julia.pyx"))
