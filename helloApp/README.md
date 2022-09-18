# helloApp

```
# Use C code in .so shared library from Swift


$ tree
.
├── Package.swift
├── README.md
├── Sources
│   ├── helloApp
│   │   └── main.swift
│   ├── helloLib
│   │   └── helloLib.swift
│   └── soLib
│       ├── hello.c
│       ├── hello.h
│       ├── libhello.so
│       ├── Makefile
│       └── module.modulemap

6 directories, 10 files
$
$
$ cat Sources/helloApp/main.swift
import Foundation
import helloLib
import soLib

print(#fileID, #line, "")
let a = helloLib()  // swift library
hello()             // C library with so
$
$
$ cat Sources/helloLib/helloLib.swift
public struct helloLib{
    public init(){
        print(#fileID, #line, "")
    }
}
$
$
$ cat Sources/soLib/module.modulemap
module soLib {
    header "/usr/include/stdio.h"
    header "./hello.h"

    link "c"
    link "hello"
    export *
}
$
$
$ cat Package.swift
// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "helloApp",
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library( name: "helloLib", targets: ["helloLib"]),
        .executable( name: "helloApp", targets: ["helloApp"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target( name: "helloLib", dependencies: []),
        .systemLibrary( name: "soLib"),
        .executableTarget( name: "helloApp", dependencies: ["helloLib", "soLib"]),
        .testTarget( name: "helloAppTests", dependencies: ["helloApp"]),
    ]
)
$


---

$ swift build  # generate .build/debug

$ cd ~/helloApp/Sources/soLib/
$ make
$ mv hello libhello.so

$ cd ~/helloApp
$ cp Sources/MySO/libhello.so .build/debug

$ swift build  -Xlinker -L/home/ljh/helloApp/Sources/soLib  -Xlinker -L/usr/lib64

$ swift package init --type executable
$ swift package init --type library
$ swift package clean
$ swift build
$ swift build -c release
$ ls .build/x86_64-apple-macosx
build.db  debug  release
$ swift test

---

https://forums.swift.org/t/system-target-library-how-to-use-them/18196/2

https://github.com/apple/swift-package-manager/blob/263171977ebcd47f4aaca1202cff5a96c5158a64/Documentation/Usage.md#import-system-libraries

```
