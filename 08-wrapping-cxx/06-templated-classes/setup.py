from distutils.core import setup
from Cython.Build import cythonize

setup(name="templated_classes",
      ext_modules=cythonize("templated_classes.pyx"))

