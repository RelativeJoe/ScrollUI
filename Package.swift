// swift-tools-version: 5.5

import PackageDescription

let package = Package(
    name: "ScrollUI",
    platforms: [
        .iOS(.v14)
    ],
    products: [
        .library(name: "ScrollUI", targets: ["ScrollUI"]),
    ],
    dependencies: [
        .package(
            url: "https://github.com/siteline/SwiftUI-Introspect",
            "0.1.4"..."1.3.0"
        )
    ],
    targets: [
        .target(
            name: "ScrollUI",
            dependencies: [
                .product(
                    name: "SwiftUIIntrospect",
                    package: "SwiftUI-Introspect"
                )
            ]
        ),
    ]
)
