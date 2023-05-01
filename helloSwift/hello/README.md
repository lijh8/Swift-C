# Swift package

```
- Call C function from standard library ;

- Call C function from shared library .so ;

- Call function from another file, module, package ;

$
$ tree --charset C
.
|-- foo
|   |-- Package.swift
|   |-- README.md
|   `-- Sources
|       `-- foo
|           `-- foo.swift
`-- hello
    |-- Package.swift
    |-- README.md
    `-- Sources
        |-- cfoo_dir
        |   |-- foo
        |   |-- foo.c
        |   |-- foo.d
        |   |-- foo.h
        |   |-- foo.o
        |   |-- libfoo.so
        |   |-- Makefile
        |   `-- module.modulemap
        |-- hello
        |   |-- hello2.swift
        |   `-- hello.swift
        `-- hello3_dir
            `-- hello3.swift

$

$ ls
foo hello
$

$ cd ~/hello/Sources/cfoo_dir
$ make
$ cp foo libfoo.so

$ cd ~/foo
$ swift package init # --type executable

$ cd ~/hello
$ swift package init --type executable

$ cd ~/hello
$ LD_LIBRARY_PATH=Sources/cfoo_dir swift run -Xlinker -LSources/cfoo_dir
$ swift build -Xlinker -LSources/cfoo_dir -c release
$ LD_LIBRARY_PATH=Sources/cfoo_dir/ .build/release/hello
$ swift test
$ swift package clean
$

$ vi tasks.json
  "command": "/usr/bin/swift",
  "args": [
    "build",
    "-c", "debug", // , "debug", //"release",
    "-Xswiftc", "-g", // "-g" , "-O"
    // "-Xlinker", "-L", "-Xlinker", "Sources/cfoo_dir/",
    // "-Xlinker", "-rpath", "-Xlinker", "Sources/cfoo_dir/",
  ]

$

$ vi package.swift
  .executableTarget(
    name: "hello",
    dependencies: ["cfoo_dir", "foo", "hello3_dir"],

    // Swift version 5.7.2, macOS 12.6.5 (21G531)
    // error: unknown argument: '-Xswiftc',
    // swiftSettings: [
    //   .unsafeFlags(["-Xswiftc", "-g"]), // -g -O
    // ],

    linkerSettings: [
      .unsafeFlags(["-Xlinker", "-rpath", "-Xlinker", "Sources/cfoo_dir"]),
      .unsafeFlags(["-Xlinker", "-L", "-Xlinker", "Sources/cfoo_dir"]),
    ]
  )

$

$ pwd
/Users/ljh/Documents/Swift-C/helloSwift/hello/Sources/cfoo_dir
$ ls
Makefile		foo.c			foo.h			module.modulemap
$ make
cc -Wall -Wextra -g -fPIC  -MMD -MP   -c -o foo.o foo.c
cc -shared  -dynamiclib -install_name @rpath/libfoo.dylib -current_version 1.2.3  foo.o   -o foo
$
$ cp foo libfoo.dylib
$
$ ls
Makefile		foo.c			foo.h			libfoo.dylib
foo			foo.d			foo.o			module.modulemap
$
$ otool -D libfoo.dylib
libfoo.dylib:
@rpath/libfoo.dylib
$

$ cd ../..
$ pwd
/Users/ljh/Documents/Swift-C/helloSwift/hello
$
$ swift build
Building for debugging...
ld: warning: dylib (Sources/cfoo_dir/libfoo.dylib) was built for newer macOS version (12.0) than being linked (10.13)
[8/8] Linking hello
Build complete! (4.40s)
$
$ swift run
Building for debugging...
Build complete! (0.19s)
hello
foo
$

$ otool -L .build/debug/hello
.build/debug/hello:
	/usr/lib/libobjc.A.dylib (compatibility version 1.0.0, current version 228.0.0)
	/usr/lib/libSystem.B.dylib (compatibility version 1.0.0, current version 1319.0.0)
	@rpath/libfoo.dylib (compatibility version 0.0.0, current version 1.2.3)
	@rpath/libswiftCore.dylib (compatibility version 1.0.0, current version 5.7.1)
	@rpath/libswiftDarwin.dylib (compatibility version 1.0.0, current version 0.0.0, weak)
$

```
