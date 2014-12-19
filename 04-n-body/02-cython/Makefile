all: nbody.so

nbody.so: nbody.pyx
	cython -a nbody.pyx
	python setup.py build_ext -fi

clean:
	-rm -r build nbody.so nbody.c nbody.html
