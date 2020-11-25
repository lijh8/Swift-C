# Swift-C
Swift Calls C functions from shared library (.so)

Libraries can be 3rd party user defined or system libc.so

https://forums.swift.org/t/system-target-library-how-to-use-them/18196/2

https://github.com/apple/swift-package-manager/blob/263171977ebcd47f4aaca1202cff5a96c5158a64/Documentation/Usage.md#import-system-libraries

main.swift:

hello()  // user defined function

fputs("fputs\n", stdout);  // fputs(3) from <stdio.h>

hello: C library code

$ cd hello

$ make

$ mv hello libhello.so

example: Swift wrapper code

$ cd example

$ swift package init --type executable

$ swift build -Xlinker -L../hello -Xlinker -L/usr/lib64

$ cp ../hello/libhello.so .build/debug

$ swift run

[1/1] Linking example

hello c lib

fputs

$
