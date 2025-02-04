// swift-tools-version:5.7

import PackageDescription

let package = Package(
    name: "ZipArchive",
    platforms: [
        .iOS("15.5"),
        .tvOS("15.4"),
        .macOS(.v10_15),
        .watchOS("8.4"),
        .macCatalyst("13.0")
    ],
    products: [
        .library(
            name: "ZipArchive",
            targets: ["ZipArchive", "ZipArchive_ObjC"]
        ),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "ZipArchive",
            dependencies: ["ZipArchive_ObjC"],
            path: "Source",
            exclude: [],
            publicHeadersPath: nil
        ),
        .target(
            name: "ZipArchive_ObjC",
            path: "CSource",
            resources: [
                .process("../Supporting Files/PrivacyInfo.xcprivacy"),
            ],
            cSettings: [
                .define("HAVE_INTTYPES_H"),
                .define("HAVE_PKCRYPT"),
                .define("HAVE_STDINT_H"),
                .define("HAVE_WZAES"),
                .define("HAVE_ZLIB"),
                .define("ZLIB_COMPAT"),
            ],
            linkerSettings: [
                .linkedLibrary("z"),
                .linkedLibrary("iconv"),
                .linkedFramework("Security"),
            ]
        )
    ],
    swiftLanguageVersions: [.v5]
)
