// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "hello",

    // products: [
    //     // Products define the executables and libraries a package produces, and make them visible to other packages.
    //     .library( name: "hello3_dir", targets: ["hello3_dir"]),
    // ],

    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
        .package(path: "../foo"), // other package locally
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .systemLibrary( name: "cfoo_dir"), // so library in C language
        .target( name: "hello3_dir", dependencies: []), // module inside same package
        .executableTarget(
            name: "hello",
            dependencies: ["cfoo_dir", "foo", "hello3_dir"],
            // dependencies: ["cfoo_dir", "hello3_dir"],

            // error: unknown argument: '-Xswiftc', Swift version 5.7.2
            // swiftSettings: [
            //     .unsafeFlags(["-Xswiftc", "-g"]), // -g -O
            // ]
            // ,

            linkerSettings: [
                .unsafeFlags(["-Xlinker", "-rpath", "-Xlinker", "Sources/cfoo_dir"]),
                .unsafeFlags(["-Xlinker", "-L", "-Xlinker", "Sources/cfoo_dir"]),
            ]
        )
        // .testTarget( name: "helloTests", dependencies: ["hello"]),
    ]
)
