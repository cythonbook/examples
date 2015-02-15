from distutils.core import setup
from Cython.Build import cythonize

setup(name="stl_containers",
      ext_modules=cythonize(["periodic_table.pyx",
                            "std_sort_vector.pyx"]))
