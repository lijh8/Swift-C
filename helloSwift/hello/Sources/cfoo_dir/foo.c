#include <string.h>
#include "foo.h"

// swift c interop - strcpy
char *strncpy2(char *dest, const char *src, size_t n) {
    strncpy(dest, src, n);
    return dest;
}

int *intcpy(int *dest, int src) {
    *dest = src;
    return dest;
}
