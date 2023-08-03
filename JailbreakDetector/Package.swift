// swift-tools-version: 5.8

import PackageDescription

let package = Package(
    name: "JailbreakDetector",
    products: [
        .library(
            name: "JailbreakDetector",
            targets: ["JailbreakDetector"]
        ),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "JailbreakDetector",
            dependencies: []
        ),
        .testTarget(
            name: "JailbreakDetectorTests",
            dependencies: [
                "JailbreakDetector"
            ]
        ),
    ]
)
