.PHONY : all
all:
	python setup.py build_ext -if
	gcc -O3 cfib.c main.c -o cfib.x

.PHONY : clean
clean:
	-rm -r build *.so *.pyc cyfib.c *.x wrap_fib.c
