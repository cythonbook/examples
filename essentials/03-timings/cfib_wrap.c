#include <Python.h>
#include "cfib.h"

static PyObject *wrap_fib(PyObject *self, PyObject *args)
{
    int arg;
    double result;

    if (!PyArg_ParseTuple(args, "i:fib", &arg))
        return NULL;

    result = cfib(arg);

    return Py_BuildValue("f", result);
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
