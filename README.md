# swift-c

Call C functions in .so shared library from Swift

hello:  // C library code

$ cd hello

$ make

$ mv hello libhello.so

example:  // Swift wrapper code

// no pkg-config, dnf, yum, apt

$ cd example

$ swift build -Xlinker -L../hello

$ cp ../hello/libhello.so .build/debug

$ swift run

hello c lib

$
