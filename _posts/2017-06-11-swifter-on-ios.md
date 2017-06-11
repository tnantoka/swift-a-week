---
layout: post
title: "SwifterでiOSアプリ内にサーバーをたてる"
categories: example
---

アプリ内にサーバーを用意したいことがありました。

<https://github.com/swisspol/GCDWebServer>を使えば安定してそうでしたが、せっかくなのでSwift製の<https://github.com/httpswift/swifter>を使ってみました。

{% highlight swift %}
let server = HttpServer()

server["/public/:path"] = shareFilesFromDirectory(PUBLIC_PATH)
server["/"] = { _ in .ok(.html(HTML)) }

try? server.start(in_port_t(PORT))
{% endhighlight %}

で特にはまることもなく、あっさり起動できました。お手軽でよさそうです。
