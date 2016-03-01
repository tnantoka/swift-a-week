import PackageDescription

let package = Package(
    name: "VaporWithEnv",
    dependencies: [
        .Package(url: "https://github.com/qutheory/vapor.git", majorVersion: 0),
    ]
)
