// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "aoc2025",
    targets: [
        .executableTarget(
            name: "aoc2025"
        ),
        .testTarget(
            name: "aoc2025tests",
            dependencies: ["aoc2025"]
        ),
    ]
)
