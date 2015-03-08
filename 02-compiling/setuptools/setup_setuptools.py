from setuptools import setup
from distutils.extension import Extension

import sys
if 'setuptools.extension' in sys.modules:
    m = sys.modules['setuptools.extension']
    m.Extension.__dict__ = m._Extension.__dict__

setup(name="fib",
      setup_requires=['setuptools_cython'],
      ext_modules=[Extension('fib', ['fib.pyx'])])
