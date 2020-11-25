# Swift-C
Swift Calls C function from shared library (.so)

From your own library or system library

https://forums.swift.org/t/system-target-library-how-to-use-them/18196/2

https://github.com/apple/swift-package-manager/blob/263171977ebcd47f4aaca1202cff5a96c5158a64/Documentation/Usage.md#import-system-libraries

main.swift:

hello()  // user defined

fputs("fputs\n", stdout)  // <stdio.h> libc.so

hello:

$ cd hello

$ make

$ mv hello libhello.so

example:

$ cd example

$ swift package init --type executable

$ swift build   -Xlinker -L../hello   -Xlinker -L/usr/lib64

$ cp ../hello/libhello.so .build/debug

$ swift run

Hello C World

Swift calls fputs(3)

$

