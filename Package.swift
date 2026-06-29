// swift-tools-version: 6.2

import PackageDescription

let package = Package(
    name: "CatUI",
    platforms: [
        .iOS(.v26)
    ],
    products: [
        .library(
            name: "CatUI",
            targets: ["CatUI"]
        )
    ],
    targets: [
        .target(
            name: "CatUI",
            resources: [.process("Resources")]
        )
    ]
)
