#include <stdio.h>
#include "hello.h"

#define PRINT(fmt, ...) do { \
    printf("%s:%d:%s: " fmt "\n", __FILE__, __LINE__, __func__, ##__VA_ARGS__); \
} while (0)

void hello()
{
    PRINT("");
}
