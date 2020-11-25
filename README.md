# Swift-C
Call C shared library (.so) from Swift

// https://forums.swift.org/t/system-target-library-how-to-use-them/18196/2

// https://github.com/apple/swift-package-manager/blob/263171977ebcd47f4aaca1202cff5a96c5158a64/Documentation/Usage.md#import-system-libraries

hello: C library code

$ cd hello

$ make

$ mv hello libhello.so

example: Swift wrapper code

// no pkg-config, dnf, yum, apt

$ cd example

$ swift package init --type executable

$ swift build -Xlinker -L../hello

$ cp ../hello/libhello.so .build/debug

$ swift run

hello c lib

$
