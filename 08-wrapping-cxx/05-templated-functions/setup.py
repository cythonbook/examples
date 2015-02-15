from distutils.core import setup
from Cython.Build import cythonize

setup(name="templated_funcs",
      ext_modules=cythonize("templated_funcs.pyx"))
