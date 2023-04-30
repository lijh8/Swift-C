#ifndef foo_h
#define foo_h

#include <string.h>

#ifdef __cplusplus
extern "C" {
#endif

char *strncpy2(char *dest, const char *src, size_t n);
int *intcpy(int *dest, int src);

#ifdef __cplusplus
}
#endif

#endif
