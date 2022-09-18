#include <stdio.h>
#include "hello.h"

#define PRINT(fmt, ...) \
{ \
    printf("%s:%d:%s: " fmt "\n", \
        __FILE__, __LINE__, __func__, ##__VA_ARGS__); \
}

void hello()
{
    PRINT("");
}
