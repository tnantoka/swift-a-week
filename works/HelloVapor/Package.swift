import PackageDescription

let package = Package(
    name: "HelloVapor",
    dependencies: [
        .Package(url: "https://github.com/qutheory/vapor.git", majorVersion: 0),
    ]
)