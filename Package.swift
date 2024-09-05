// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "MSViews",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "MSViews",
            targets: ["MSViews"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/Decybel07/L10n-swift.git",.upToNextMajor(from: "5.10.2")),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "MSViews",
            dependencies: [
                .product(name: "L10n-swift", package: "L10n-swift"),
            ],
            resources: []
        ),
        .testTarget(
            name: "MSViewsTests",
            dependencies: ["MSViews"],
            resources: [
            ]),
    ]
)
