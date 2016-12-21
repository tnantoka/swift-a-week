---
layout: post
title:  "Hello Vapor 3: セッション"
categories: example
---

前回の記事から時間がたってしまいましたが、今回はセッションを使ってみます。　

Serverのinitを以下のように書き換えて、アクセスのたびにカウントアップするようにします。

{% highlight swift %}
init() {
    app.get("") { request in
        let count = (Int(request.session?["count"] ?? "") ?? 0) + 1
        request.session?["count"] = "\(count)"
        return "Hello \(count)"
    }
}
{% endhighlight %}

以下のURLで試してみることができます。

http://session.vapor.swiftaweek.com/ (公開終了)

デフォルトでは`MemorySessionDriver.swift`が使われており、サーバーを再起動すると消えてしまいます。
この辺りは今後の進化に期待ですね。（自分で書いてもよさそう。） 

## ソースコード

- <https://github.com/tnantoka/swift-a-week/tree/gh-pages/works/VaporWithSession>

