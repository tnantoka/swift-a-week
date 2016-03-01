---
layout: post
title:  "Hello Vapor 1: プロジェクト作成からテストまで"
categories: example
---

Swift製のWebフレームワークが早くも乱立していますが、[GitHubで1000スター以上獲得している](https://github.com/search?o=desc&q=swift%20web&s=stars&type=Repositories&utf8=%E2%9C%93)中から、一番deployが手軽そうな[Vapor](https://github.com/qutheory/vapor)に手を出してみます。

## Swiftenvと最新版のSwiftをインストール

{% highlight sh %}
$ swift --version
Apple Swift version 2.1.1 (swiftlang-700.1.101.15 clang-700.1.81)
Target: x86_64-apple-darwin15.0.0

$ brew install kylef/formulae/swiftenv
$ echo 'if which swiftenv > /dev/null; then eval "$(swiftenv init -)"; fi' >> ~/.bash_profile
$ source ~/.bash_profile 

$ swiftenv install swift-DEVELOPMENT-SNAPSHOT-2016-02-25-a

$ swift --version
Apple Swift version 3.0-dev (LLVM b361b0fc05, Clang 11493b0f62, Swift fc261045a5)
Target: x86_64-apple-macosx10.9

$ swiftenv version
DEVELOPMENT-SNAPSHOT-2016-02-25-a
{% endhighlight %}

## Xcodeで使うSwiftの設定

Xcode 7.3を使っていれば、メニューの`Xcode` -> `Toolchains`から切り替えられます。

## プロジェクト作成

1. `OS X` -> `Application` -> `Command Line Tool`から`HelloVapor`プロジェクトを作成
1. `Import Paths`に`$(SRCROOT)/.build/debug`と`$(SRCROOT)/.build/release`を設定（コード補完のため）
1. プロジェクトのディレクトリで`$ swift build --init`を実行
1. 作成されたファイルをXcodeに追加する（SourcesのみAdd to targetsを設定）
1. `HelloVapor`ディレクトリと`main.swift`を削除
1. Xcode上で実行

{% highlight sh %}
Hello, world!
Program ended with exit code: 0
{% endhighlight %}

コンソールに上記のメッセージが表示されればOKです。

## Vaporを導入

`Package.swift`を変更します。

{% highlight swift %}
import PackageDescription

let package = Package(
    name: "HelloVapor",
    dependencies: [
        .Package(url: "https://github.com/qutheory/vapor.git", majorVersion: 0),
    ]
)
{% endhighlight %}

このまま`swift build`を実行すると、`ld: framework not found XCTest for architecture x86_64`で失敗するので、`build.sh`というシェルスクリプトを作って対応します。

{% highlight sh %}
#!/bin/sh

echo "Downloading dependencies..."
swift build &>/dev/null
echo "Fixing SPM bug..."
rm -rf Packages/Vapor-0.2.6/Tests/ &>/dev/null
echo "Building..."
swift build
echo "Running..."
.build/debug/HelloVapor
{% endhighlight %}

{% highlight sh %}
$ ./build.sh 
Downloading dependencies...
Fixing SPM bug...
Building...
Compiling Swift Module 'HelloVapor' (1 sources)
Linking HelloVapor
Running...
Hello, world!
{% endhighlight %}

`Server.swift`を追加します。

{% highlight swift %}
import Vapor

struct Server {
    let app = Application()
    
    init() {
        app.get("welcome") { request in
            return "Hello"
        }
    }

    func start() {
        app.start(port: 8080)
    }
}
{% endhighlight %}

`main.swift`を書き換えます。

{% highlight swift %}
let server = Server()
server.start()
{% endhighlight %}

再度`build.sh`を実行して、`http://localhost:8080/welcome`にアクセスすれば、`Hello`と表示されるはずです。

## 自動テスト

`Tests/HelloVapor/ServerTests.swift`を作成します。

{% highlight swift %}
import XCTest
@testable import HelloVapor
@testable import Vapor

class ServerTests: XCTestCase {

    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }

    func testStart() {
        let server = Server()
        server.app.bootRoutes()

        let request = Request(
            method: .Get,
            path: "welcome",
            address: nil,
            headers: ["host": "example.com"],
            body: []
        )
        
        do {
            let result = server.app.router.route(request)!
            var bytes = try result(request: request).data
            
            let utf8 = NSData(bytes: &bytes , length: bytes.count)
            let string = String(data: utf8, encoding: NSUTF8StringEncoding)
            XCTAssert(string == "<html><meta charset=\"UTF-8\"><body>Hello</body></html>")
        } catch {
            XCTFail()
        }
    }
}
{% endhighlight %}

`build.sh`を実行してすぐ止めて`swift test`を実行します。（build.shを書き換えた方がよさそうですが割愛します）

{% highlight sh %}
Test Suite 'ServerTests' passed at 2016-02-28 00:26:39.491.
   Executed 1 test, with 0 failures (0 unexpected) in 0.004 (0.004) seconds
{% endhighlight %}

これで一応形は整いました。
次からは簡単なWebサービスに必要そうな機能の実装方法を調べていきたいと思います。

## ソースコード

<https://github.com/tnantoka/swift-a-week/tree/gh-pages/works/HelloVapor>

## 参考

- <http://qiita.com/nakailand/items/c68514263c1fadcd695e>
- <http://ankit.im/swift/2016/02/17/swift-package-manager-testing-preview/>
- <https://github.com/qutheory/vapor-installer/pull/5#issuecomment-189489328>
- <https://github.com/qutheory/vapor/blob/master/Tests/Vapor/RouterTests.swift>

