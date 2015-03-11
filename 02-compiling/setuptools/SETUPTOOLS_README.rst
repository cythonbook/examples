================================================
For those desiring to use setuptools with Cython
================================================

Note that the ``Cython.Build.cythonize()`` utility creates plain,
non-monkey-patched ``distutils.Extension`` objects.  These do not work out of
the box with setuptools, due to various (some would say perfidious)
monkey-patches made by setuptools to the ``disutils.Extension`` module,
rendering ``setuptools.Extension`` objects useless for compiling Cython
``.pyx`` extension modules.

Currently, the best workaround is to use the `setuptools_cython
<https://pypi.python.org/pypi/setuptools_cython/>`_ module.

The ``setup_setuptools.py`` script uses this module to demonstrate how to use
setuptools to build the ``fib.pyx`` module.
