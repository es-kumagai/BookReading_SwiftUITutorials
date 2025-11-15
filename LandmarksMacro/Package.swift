// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription
import CompilerPluginSupport

let package = Package(
    name: "LandmarksMacro",
    platforms: [.macOS(.v26), .iOS(.v26), .watchOS(.v26), .macCatalyst(.v26)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "LandmarksMacro",
            targets: ["LandmarksMacro"]
        ),
        .executable(
            name: "LandmarksMacroClient",
            targets: ["LandmarksMacroClient"]
        ),
    ],
    dependencies: [
//        .package(url: "https://github.com/swiftlang/swift-syntax.git", revision: "4799286537280063c85a32f09884cfbca301b1a1"),
        .package(url: "https://github.com/swiftlang/swift-syntax.git", from: "602.0.0"),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        // Macro implementation that performs the source transformation of a macro.
        .macro(
            name: "LandmarksMacroMacros",
            dependencies: [
                .product(name: "SwiftSyntaxMacros", package: "swift-syntax"),
                .product(name: "SwiftCompilerPlugin", package: "swift-syntax")
            ]
        ),

        // Library that exposes a macro as part of its API, which is used in client programs.
        .target(
            name: "LandmarksMacro",
            dependencies: ["LandmarksMacroMacros"],
            linkerSettings: [
            ]
        ),

        // A client of the library, which is able to use the macro in its own code.
        .executableTarget(name: "LandmarksMacroClient", dependencies: ["LandmarksMacro"]),

    ]
)
