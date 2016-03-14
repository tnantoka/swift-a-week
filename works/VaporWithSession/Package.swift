import PackageDescription

let package = Package(
    name: "VaporWithSession",
    dependencies: [
      .Package(url: "https://github.com/qutheory/vapor.git", majorVersion: 0),
    ]
)
