from distutils.core import setup, Extension
from Cython.Build import cythonize

exts = ([Extension("cfib", sources=["cfib.c", "cfib_wrap.c"])] +
        cythonize("cyfib.pyx") +
        cythonize([Extension("wrap_fib", sources=["cfib.c", "wrap_fib.pyx"])])
        )

setup(
    ext_modules = exts,
)
