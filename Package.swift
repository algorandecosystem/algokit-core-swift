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
      url: "https://github.com/algorandecosystem/algokit-core-swift/releases/download/v1.0.0-alpha.84/algokit_transact.xcframework.zip",
      checksum: "99523ee3f5ce52efb09ca468a5df14831fb07ae2bd3887d4875a5e8724570130"
    ),
    .binaryTarget(
      name: "algokit_cryptoFFI",
      url: "https://github.com/algorandecosystem/algokit-core-swift/releases/download/v1.0.0-alpha.84/algokit_crypto.xcframework.zip",
      checksum: "f47b45140816721e2b4f98d1871dc475ec9a8ee27c8550b93cdde8902c5356ee"
    ),
    .binaryTarget(
      name: "algokit_composerFFI",
      url: "https://github.com/algorandecosystem/algokit-core-swift/releases/download/v1.0.0-alpha.84/algokit_composer.xcframework.zip",
      checksum: "d80949842917f3a2be8e8e4bc05c0dfa7cf22758104dabe7ac3add3493b6d4fb"
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