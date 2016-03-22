---
layout: post
title:  "Hello Vapor 4: 自作ライブラリと一緒に使う"
categories: example
---

今回は依存関係を追加してみます。　

Package.swiftに[Symday](https://github.com/tnantoka/Symday)を追加します。

{% highlight swift %}
import PackageDescription

let package = Package(
    name: "VaporWithMyLib",
    dependencies: [
      .Package(url: "https://github.com/qutheory/vapor.git", majorVersion: 0),
      .Package(url: "https://github.com/tnantoka/Symday.git", majorVersion: 0),
    ]
)
{% endhighlight %}

そして、Serverのinitを書き換えて、日付を返すようにしてみます。

{% highlight swift %}
init() {
    app.get("") { request in
        let date = Symday().format(NSDate())
        return "Hello \(date)"
    }
}
{% endhighlight %}

以下のURLで試してみることができます。

<http://my-lib.vapor.swiftaweek.com/>

iOSでもサーバサイドでも同じライブラリを使えるのはいいですね。
今後ライブラリを作る時、UIKitに依存しないものはできるだけLinux対応にしていこうと思います。

## ソースコード

- <https://github.com/tnantoka/swift-a-week/tree/gh-pages/works/VaporWithMyLib>

