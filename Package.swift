// swift-tools-version: 5.8

// WARNING:
// This file is automatically generated.
// Do not edit it by hand because the contents will be replaced.

import PackageDescription
import AppleProductTypes

let package = Package(
    name: "Zeitplan",
    platforms: [
        .iOS("17.0")
    ],
    products: [
        .iOSApplication(
            name: "Zeitplan",
            targets: ["AppModule"],
            bundleIdentifier: "yeff.dev.SSCProject",
            teamIdentifier: "56HRAPS4XW",
            displayVersion: "1.0",
            bundleVersion: "1",
            appIcon: .asset("AppIcon"),
            accentColor: .presetColor(.orange),
            supportedDeviceFamilies: [
                .pad,
                .phone
            ],
            supportedInterfaceOrientations: [
                .portrait,
                .landscapeRight,
                .landscapeLeft,
                .portraitUpsideDown(.when(deviceFamilies: [.pad]))
            ],
            appCategory: .healthcareFitness
        )
    ],
    dependencies: [
        .package(url: "https://github.com/MAJKFL/Welcome-Sheet", .branch("main"))
    ],
    targets: [
        .executableTarget(
            name: "AppModule",
            dependencies: [
                .product(name: "WelcomeSheet", package: "welcome-sheet")
            ],
            path: ".",
            resources: [
                .process("Resources")
            ]
        )
    ]
)