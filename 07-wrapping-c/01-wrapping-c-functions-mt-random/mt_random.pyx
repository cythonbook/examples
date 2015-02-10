# distutils: sources=["mt19937ar.c"]
cimport mt

def init_state(unsigned long s):
    mt.init_genrand(s)

def rand():
    return mt.genrand_real1()
