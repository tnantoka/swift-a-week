import PackageDescription

let package = Package(
    name: "VaporWithMyLib",
    dependencies: [
      .Package(url: "https://github.com/qutheory/vapor.git", majorVersion: 0),
      .Package(url: "https://github.com/tnantoka/Symday.git", majorVersion: 0),
    ]
)
