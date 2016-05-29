---
layout: post
title:  "NSLinguisticTaggerで分かち書き"
categories: example
---

日本語の分かち書きをしたいニーズがあったので、SwiftからNSLinguisticTaggerを使ってみました。
（品詞を返してくれたりはしないので、形態素解析ではないのです…）

{% highlight swift %}
import Foundation

let string = "このプログラムはSwiftで書かれています。"
var tokens = [String]()
string.enumerateLinguisticTagsInRange(
    string.startIndex..<string.endIndex,
    scheme: NSLinguisticTagSchemeTokenType,
    options: [.OmitWhitespace, .OmitPunctuation, .JoinNames],
    orthography: nil) { (tag, tokenRange, sentenceRange, stop) in
        let token = string.substringWithRange(tokenRange)
        tokens.append(token)
}
tokens.joinWithSeparator("|") // この|プログラム|は|Swift|で|書|か|れ|て|い|ます
{% endhighlight %}

なんという手軽さでしょうか…。

## ソースコード

- <https://github.com/tnantoka/swift-a-week/tree/gh-pages/works/NSLinguisticTagger.playground>

## 参考

- [はるふ's Innovation!!: Swift(iPhone)での形態素解析〜NSLinguisticTagger〜](http://ha1f-blog.blogspot.jp/2015/04/swiftiphonenslinguistictagger.html)
- [自然言語のテキストを属性で区分する - Qiita](http://qiita.com/shu223/items/cf9e25ff60804044f437)
- [enumerateLinguisticTagsInRange](https://developer.apple.com/library/ios/documentation/Cocoa/Reference/Foundation/Classes/NSString_Class/#//apple_ref/occ/instm/NSString/enumerateLinguisticTagsInRange:scheme:options:orthography:usingBlock:)
