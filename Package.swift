// swift-tools-version:4.0

import PackageDescription

let package = Package(
    name: "Itemize",
    targets: [
        .target(name:"ItemizeCore"),
        .target(name:"Itemize", dependencies:["ItemizeCore"]),
        .testTarget(name:"ItemizeCoreTests", dependencies:["ItemizeCore"])
    ]
)
