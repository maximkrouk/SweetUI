// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "SweetUI",
    platforms: [
        .iOS(.v10),
        //.macOS(.v10_11)
    ],
    products: [
        .library(
            name: "SweetUI",
            targets: ["SweetUI"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/maximkrouk/UICocoa.git", from: "1.0.0")
    ],
    targets: [
        .target(
            name: "SweetUI",
            dependencies: [
                .product(name: "UICocoa", package: "UICocoa")
            ]
        ),
        .testTarget(
            name: "SweetUITests",
            dependencies: [
                .target(name: "SweetUI")
            ]
        ),
    ]
)
