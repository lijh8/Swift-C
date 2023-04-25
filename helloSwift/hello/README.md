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

```
