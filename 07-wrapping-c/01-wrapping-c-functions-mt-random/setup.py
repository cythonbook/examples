from distutils.core import setup, Extension
from Cython.Build import cythonize

ext = Extension("mt_random",
                sources=["mt_random.pyx", "mt19937ar.c"])

setup(name="mersenne_random",
      ext_modules = cythonize([ext]))
