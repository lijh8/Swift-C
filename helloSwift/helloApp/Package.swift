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
        .package(path: "../helloLib"),                  //other local package
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
