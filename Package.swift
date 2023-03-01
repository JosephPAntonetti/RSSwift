// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "RSSwift",
  platforms: [
    .iOS(.v16),
    .watchOS(.v8),
    .macOS(.v13),
  ],
  products: [
    .library(
      name: "RSSwift",
      targets: ["RSSwift"]
    )
  ],
  dependencies: [
    .package(url: "https://github.com/groue/GRDB.swift.git", from: "6.8.0"),
    .package(url: "https://github.com/lukaskubanek/LoremSwiftum.git", from: "2.2.1"),
  ],
  targets: [
    .target(
      name: "RSSwift",
      dependencies: [
        "LoremSwiftum",
        .product(name: "GRDB", package: "GRDB.swift"),
      ]
    ),
    .testTarget(
      name: "RSSwiftTests",
      dependencies: ["RSSwift"]
    ),
  ]
)
