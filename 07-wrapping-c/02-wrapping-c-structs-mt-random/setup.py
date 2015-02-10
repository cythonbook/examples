from distutils.core import setup, Extension
from Cython.Build import cythonize

ext_type = Extension("mt_random_type",
                     sources=["mt_random_type.pyx",
                              "mt19937ar-struct.c"])

setup(name="mersenne_random",
      ext_modules = cythonize([ext_type]))
