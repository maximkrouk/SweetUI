// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "SweetUI",
    platforms: [
        .iOS(.v10)
    ],
    products: [
        .library(
            name: "SweetUI",
            targets: ["SweetUI"]
        ),
    ],
    targets: [
        .target(name: "SweetUI")
    ]
)
