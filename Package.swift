// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.
import PackageDescription

let package = Package(
    name: "AttributeKit",
    platforms: [
        .iOS(.v13),
        .macOS(.v10_15),
        .tvOS(.v13),
        .watchOS(.v4)
    ],
    products: [
        .library(
            name: "AttributeKit",
            targets: ["AttributeKit"]
        )
    ],
    dependencies: [
        // uncomment this code to test
        .package(url: "https://github.com/Quick/Quick.git", from: "6.1.0"),
        .package(url: "https://github.com/Quick/Nimble.git", from: "11.2.1")
    ],
    targets: [
        .target(
            name: "AttributeKit",
            dependencies: [],
            path: "AttributeKit/Classes"
        ),
        // uncomment this code to test
        .testTarget(
            name: "AttributeKitTests",
            dependencies: [
                "AttributeKit", "Quick", "Nimble"
            ],
            path: "Example/Tests",
            exclude: ["Info.plist"]
        )
    ]
)
