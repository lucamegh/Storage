// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "Storage",
    products: [
        .library(
            name: "Storage",
            targets: ["Storage"]
        ),
    ],
    targets: [
        .target(
            name: "Storage",
            dependencies: []
        ),
        .testTarget(
            name: "StorageTests",
            dependencies: ["Storage"]
        ),
    ]
)
