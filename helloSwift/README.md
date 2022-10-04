<pre>

```

$ cd ~/helloSwift
$ ls
helloApp  helloLib
$ find . -print | sed -e 's;[^/]*/;|____;g;s;____|; |;g'

.
|____helloSwift
| |____helloApp
| | |____Package.swift
| | |____Sources
| | | |____helloApp
| | | | |____helloApp.swift
| | | | |____helloLib3.swift
| | | |____soLib
| | | | |____hello.c
| | | | |____Makefile
| | | | |____hello.h
| | | | |____module.modulemap
| | | | |____libhello.so
| | | |____helloLib2
| | | | |____helloLib2.swift
| |____helloLib
| | |____Package.swift
| | |____Sources
| | | |____helloLib
| | | | |____helloLib.swift
$


$ cat helloApp/Package.swift
// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "helloApp",
    products: [
        // .executable( name: "helloApp", targets: ["helloApp"]),
        // .library( name: "helloLib2", targets: ["helloLib2"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
        .package(path: "../helloLib"),                  //other package locally
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .executableTarget( name: "helloApp", dependencies: ["helloLib2", "helloLib", "soLib"]),
        .systemLibrary( name: "soLib"),                 //so library in C language
        .target( name: "helloLib2", dependencies: []),  //module inside same package
        //.testTarget( name: "helloAppTests", dependencies: ["helloApp"]),
    ]
)
$


$ cat helloApp/Sources/helloApp/helloApp.swift
import helloLib2 //module inside same package
import helloLib  //module from other package
import soLib     //so library in C language

@main
public struct helloApp {
    public private(set) var text = "Hello, World!"

    public static func main() {
        print(#fileID, #line, helloApp().text)

        var a = helloLib3() //file inside same module
        var b = helloLib2()
        var c = helloLib()
        hello()
    }
}
$


$
$ cat helloApp/Sources/helloApp/helloLib3.swift
public struct helloLib3 {
    public init() {
        print(#fileID, #line, "")
    }
}
$


$ cat helloApp/Sources/helloLib2/helloLib2.swift
public struct helloLib2 {
    public init() {
        print(#fileID, #line, "")
    }
}
$


$ cat helloApp/Sources/soLib/hello.c
#include <stdio.h>
#include "hello.h"

#define PRINT(fmt, ...) do { \
    printf("%s:%d:%s: " fmt "\n", __FILE__, __LINE__, __func__, ##__VA_ARGS__); \
} while (0)

void hello()
{
    PRINT("");
}
$


$ cat helloApp/Sources/soLib/hello.h
#ifndef hello_h
#define hello_h

void hello();

#endif
$


$ cat helloApp/Sources/soLib/Makefile
# build shared library with -fPIC, -shared
CFLAGS   = -Wall -Wextra -g  -fPIC # -O3  # CXXFLAGS for .cpp
LDFLAGS  = -shared # -L../hello #
LDLIBS   = # -lhello
CPPFLAGS = -MMD -MP  # -I../hello
#CC      = $(CXX)  # link with CXX for .cpp

# target name is basename of one of the source files
hello : $(patsubst %.c,%.o,$(wildcard *.c))  # .cpp
-include *.d
clean : ; -rm -fr *.o *.d
.PHONY : clean
$


$ cat helloApp/Sources/soLib/module.modulemap
module soLib {
    // header "/usr/include/stdio.h"
    header "./hello.h"

    // link "c"
    link "hello"

    export *
}
$


$ cat helloLib/Package.swift
// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "helloLib",
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library( name: "helloLib", targets: ["helloLib"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target( name: "helloLib", dependencies: []),
        .testTarget( name: "helloLibTests", dependencies: ["helloLib"]),
    ]
)
$


$ cat helloLib/Sources/helloLib/helloLib.swift
public struct helloLib {
    public private(set) var text = "Hello, World!"

    public init() {
        print(#fileID, #line, "")
    }
}
$


$ cd ~/helloSwift/helloApp/Sources/soLib/
$ make
$ mv hello libhello.so

$ cd ~/helloSwift/helloApp/
$ swift build  -Xlinker -LSources/soLib
$ LD_LIBRARY_PATH=Sources/soLib  ./.build/debug/helloApp

$ cp Sources/soLib/libhello.so .build/debug
$ swift run

$ swift test
$ swift build -c release

$ swift package init --type executable
$ swift package init --type # library
$ swift package clean

---

https://forums.swift.org/t/system-target-library-how-to-use-them/18196/2

https://github.com/apple/swift-package-manager/blob/263171977ebcd47f4aaca1202cff5a96c5158a64/Documentation/Usage.md#import-system-libraries

https://forums.swift.org/t/wrap-a-local-c-so-shared-library/42259/4

```

</pre>
