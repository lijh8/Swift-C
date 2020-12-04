# Swift-C
Swift Calls C function from shared library

It can be your own library or system library like libc.so

Swift 5.3, Fedora 33

hello.c:
```
#include <stdio.h>
#include "hello.h"
void hello(void) {
    printf("Hello C World\n");
}
```
main.swift:
```
var buf = [CChar](repeating: 0, count: 1024)
fputs("Your input: ", stdout)  // system function
fgets(&buf, Int32(buf.count), stdin)
print(String(cString: buf))

hello()  // user function
```
hello:
```
$ cd hello
$ make
$ mv hello libhello.so
```
example:
```
$ cd example
$ swift package init --type executable
$ swift build  -Xlinker -L../hello  -Xlinker -L/usr/lib64
$ cp ../hello/libhello.so .build/debug
$ swift run
Your input: hello world
Result: hello world

Hello C World
$
```

1. [System target library: How to use them](https://forums.swift.org/t/system-target-library-how-to-use-them/18196/2)
2. [swift-package-manager/Documentation/Usage.md](https://github.com/apple/swift-package-manager/blob/263171977ebcd47f4aaca1202cff5a96c5158a64/Documentation/Usage.md#import-system-libraries)
3. [C Interoperability](https://developer.apple.com/documentation/swift/swift_standard_library/c_interoperability)
4. [Read text file line by line](https://forums.swift.org/t/read-text-file-line-by-line/28852/6)
