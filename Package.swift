// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "AlgoKitUtils",
  platforms: [.iOS(.v15), .macOS(.v12), .macCatalyst(.v15)],
  products: [
    .library(name: "AlgoKitTransact", targets: ["AlgoKitTransact"]),
    .library(name: "AlgoKitCrypto", targets: ["AlgoKitCrypto"]),
    .library(name: "AlgoKitUtils", targets: ["AlgoKitUtils"]),
  ],
  dependencies: [
    .package(url: "https://github.com/pebble8888/ed25519swift.git", from: "1.2.7")
  ],
  targets: [
    .binaryTarget(
      name: "algokit_transactFFI",
      url: "https://github.com/algorandecosystem/algokit-core-swift/releases/download/v0.0.10/algokit_transact.xcframework.zip",
      checksum: "7834240f526658c9aee6ec3526cf2690ac3aa392a1b64fcc480473e8650c0899"
    ),
    .binaryTarget(
      name: "algokit_cryptoFFI",
      url: "https://github.com/algorandecosystem/algokit-core-swift/releases/download/v0.0.10/algokit_crypto.xcframework.zip",
      checksum: "8f2ec4220fd5cfa8db2dc7ac85b2c36f3b89294ebe61688243a8e283c73299d8"
    ),

    .target(
      name: "AlgoKitTransactFFI",
      dependencies: ["algokit_transactFFI"],
      path: "Sources/AlgoKitTransactFFI"
    ),
    .target(
      name: "AlgoKitCryptoFFI",
      dependencies: ["algokit_cryptoFFI"],
      path: "Sources/AlgoKitCryptoFFI"
    ),

    .target(
      name: "AlgoKitTransact",
      dependencies: ["AlgoKitTransactFFI"],
      path: "Sources/AlgoKitTransact"
    ),
    .target(
      name: "AlgoKitCrypto",
      dependencies: ["AlgoKitCryptoFFI"],
      path: "Sources/AlgoKitCrypto"
    ),
    .target(
      name: "AlgoKitUtils",
      dependencies: ["AlgoKitTransact", "AlgoKitCrypto"],
      path: "Sources/AlgoKitUtils"
    ),

    .testTarget(
      name: "AlgoKitTransactTests",
      dependencies: [
        "AlgoKitTransact",
        "ed25519swift",
      ],
      resources: [
        .process("Resources/test_data.json")
      ]
    ),
    .testTarget(
      name: "AlgoKitCryptoTests",
      dependencies: ["AlgoKitCrypto"]
    ),
  ]
)