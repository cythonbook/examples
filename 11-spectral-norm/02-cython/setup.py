from distutils.core import setup
from Cython.Build import cythonize

setup(name='spectral_norm',
      ext_modules = cythonize('spectral_norm.pyx'))
