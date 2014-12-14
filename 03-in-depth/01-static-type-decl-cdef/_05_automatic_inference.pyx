def automatic_inference():
    i = 1
    d = 2.0
    c = 3+4j
    r = i * d + c
    return r

cimport cython

@cython.infer_types(True)
def more_inference():
    i = 1
    d = 2.0
    c = 3+4j
    r = i * d + c
    return r
