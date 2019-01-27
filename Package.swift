// swift-tools-version:4.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "DangerSwiftCoverage",
    products: [
        // Products define the executables and libraries produced by a package, and make them visible to other packages.
        .library(
            name: "DangerSwiftCoverage",
            targets: ["DangerSwiftCoverage"]),
        .library(name: "DangerDeps", type: .dynamic, targets: ["DangerDependencies"]) // dev
    ],
    dependencies: [
        .package(url: "https://github.com/danger/swift.git", from: "1.0.0"),
        .package(url: "https://github.com/JohnSundell/ShellOut", from: "2.1.0"),
        .package(url: "https://github.com/f-meloni/Rocket", from: "0.4.0"), // dev
        .package(url: "https://github.com/f-meloni/danger-swift-xcodesummary", from: "0.1.0")
    ],
    targets: [
        .target(name: "DangerDependencies", dependencies: ["Danger", "DangerSwiftCoverage", "DangerXCodeSummary"]), // dev
        .target(
            name: "DangerSwiftCoverage",
            dependencies: ["Danger", "ShellOut"]),
        .testTarget(
            name: "DangerSwiftCoverageTests",
            dependencies: ["DangerSwiftCoverage", "DangerFixtures"]),
    ]
)
