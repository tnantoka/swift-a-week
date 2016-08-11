---
layout: post
title:  "ドル円の相場を取得する"
categories: tips
---

今回も <https://github.com/tnantoka/itoa> からの移植です。
YQLを使えば米Yahooから簡単に相場情報を取得することができます。便利。

{% highlight swift %}
let urlString = "https://query.yahooapis.com/v1/public/yql?q=select%20*%20from%20yahoo.finance.xchange%20where%20pair%20in%20%28%22USDJPY%22%29&format=json&env=store%3A%2F%2Fdatatables.org%2Falltableswithkeys"
let url = NSURL(string: urlString)!

let session = NSURLSession.sharedSession()
let task = session.dataTaskWithURL(url) { (data, response, error) in
    let json = try! NSJSONSerialization.JSONObjectWithData(data!, options: [])
    let query = json["query"]!
    let results = query!["results"]!
    let rate = results!["rate"]!
    let usdjpy = rate!["Rate"] // "101.1950"
}
task.resume()
{% endhighlight %}

Playgroud上でやるとたまにエラーの結果が返ってくるようですが原因不明です…。
（Androidで触っている時は正常応答しかなかったです。）

## ソースコード

<https://github.com/tnantoka/swift-a-week/tree/gh-pages/works/FetchCurrency.playground>

