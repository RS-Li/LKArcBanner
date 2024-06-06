// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "LKArcBanner",
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(name: "LKArcBanner", targets: ["LKArcBanner"]),
    ],
    
    dependencies: [
        .package(url: "https://github.com/SnapKit/SnapKit.git", .upToNextMajor(from: "5.0.1"))
    ],
    
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "LKArcBanner",
            dependencies: [
                .product(name: "SnapKit", package: "SnapKit")
            ]
        ),
        
        .testTarget(
            name: "LKArcBannerTests",
            dependencies: ["LKArcBanner"]),
    ]
)
