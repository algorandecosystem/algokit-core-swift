// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "AlgoKitUtils",
  platforms: [.iOS(.v15), .macOS(.v12), .macCatalyst(.v15)],
  products: [
    .library(name: "AlgoKitTransact", targets: ["AlgoKitTransact"]),
    .library(name: "AlgoKitCrypto", targets: ["AlgoKitCrypto"]),
    .library(name: "AlgoKitComposer", targets: ["AlgoKitComposer"]),
    .library(name: "AlgoKitUtils", targets: ["AlgoKitUtils"]),
  ],
  dependencies: [
    .package(url: "https://github.com/pebble8888/ed25519swift.git", from: "1.2.7")
  ],
  targets: [
    .binaryTarget(
      name: "algokit_transactFFI",
      url: "https://github.com/algorandecosystem/algokit-core-swift/releases/download/v1.0.0-alpha.85/algokit_transact.xcframework.zip",
      checksum: "e7066f3a3672f06bf6c9aa7fe7ac2b1d7c26b704f0125541a17d8ca2a9734e73"
    ),
    .binaryTarget(
      name: "algokit_cryptoFFI",
      url: "https://github.com/algorandecosystem/algokit-core-swift/releases/download/v1.0.0-alpha.85/algokit_crypto.xcframework.zip",
      checksum: "905ff2d65087199e23f14e29d1d18e323f13b707093fcf9ff7c5fcb65df080f4"
    ),
    .binaryTarget(
      name: "algokit_composerFFI",
      url: "https://github.com/algorandecosystem/algokit-core-swift/releases/download/v1.0.0-alpha.85/algokit_composer.xcframework.zip",
      checksum: "139b9e57b89392c141560f0d21d3bfc2163d1b153f8010ad61cbd4bcf5bb540e"
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
      name: "AlgoKitComposerFFI",
      dependencies: ["algokit_composerFFI"],
      path: "Sources/AlgoKitComposerFFI"
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
      name: "AlgoKitComposer",
      dependencies: ["AlgoKitComposerFFI"],
      path: "Sources/AlgoKitComposer"
    ),
    .target(
      name: "AlgoKitUtils",
      dependencies: ["AlgoKitTransact", "AlgoKitCrypto", "AlgoKitComposer"],
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