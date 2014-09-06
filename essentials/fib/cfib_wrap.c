#include <Python.h>
#include "cfib.h"

static PyObject *wrap_fib(PyObject *self, PyObject *args)
{
    long arg, result;

    if (!PyArg_ParseTuple(args, "l:fib", &arg))
        return NULL;

    result = fib(arg);

    return Py_BuildValue("l", result);
}

static PyMethodDef funcs[] = {
    {"fib", wrap_fib, METH_VARARGS, "Calculate the nth fibonnaci number."},
    {NULL, NULL, 0, NULL} /* sentinel */
};

PyMODINIT_FUNC
initcfib(void)
{
    (void) Py_InitModule("cfib", funcs);
}
