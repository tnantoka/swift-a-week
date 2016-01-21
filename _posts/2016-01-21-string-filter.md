---
layout: post
title:  "Swiftらしく書く練習: StringFilter"
categories: book
---

[\[Week 2\] Functional Swiftを読む その1](/book/2016/01/10/read-functional-swift-1.html)で、CIImageの例を参考に書いた[String用のFilter](https://github.com/tnantoka/swift-a-week/blob/gh-pages/works/FunctionalSwift.playground/Contents.swift#L7)がわりと題材としてよさそうだったので、ライブラリ化してみました。
今までCocoaPods用のものはいくつか公開したことがありましたが、今回初めてCarthage対応のフレームワークとして作りました。　

<https://github.com/tnantoka/StringFilter>

## 使い方

{% highlight swift %}
import StringFilter

let message = "ifmmp-!xpsme"
let filters = [ 
    StringFilter.Shift(-1),
    .Capitalize,
    .Replace("$", "!")
]
print(message.str_filter(filters)) // "Hello, World!"
{% endhighlight %}

このような感じで使えます。
[ビルトインのフィルター](https://github.com/tnantoka/StringFilter#built-in-filters)がまだしょぼいですが、[独自フィルターも定義可能](https://github.com/tnantoka/StringFilter#custom-filter)です。

また、独自演算子があまり好きではない[^1]ので、複数フィルターの掛けあわせは`*`で行うようにしました。

## Carthage

Carthage対応のフレームワークは以下の様な手順で作成しました。

### プロジェクトの作成

1. File -> New -> Project
2. iOS -> Framework & Library -> Cocoa Touch Framework -> Next  
   ✔ Include Unit Tests
3. Edit Scheme -> Test ->  
   ✔ Gather coverage data  
   ✔ Shared 

これで、`Command + U`でテストできてカバレッジも取れる状態です。

### Carthageのインストール

{% highlight sh %}
$ brew update
$ brew install carthage
$ carthage version
0.11.0
{% endhighlight %}

### 公開前のテスト

`$ git tag 0.0.1`などをした状態で、

{% highlight ruby %}
# Cartfile
git "file://path/to/framework"
{% endhighlight %}

と書けばローカルからインストールできました。（相対パスや`~`は使えませんでした）
タグ打ち直した後、`$ carthage update`すれば普通に更新もできました。

### Travis CI

以下のように書いたら動きました。

<https://github.com/tnantoka/StringFilter/blob/master/.travis.yml>

### 参考

- <https://robots.thoughtbot.com/creating-your-first-ios-framework>　
- <https://github.com/Carthage/Carthage#supporting-carthage-for-your-framework>

だいぶSwiftっぽく書けるようになってきたかな、と思います。
そろそろ何かアプリを作ろうかと考え中です。

[^1]: 他の言語にある演算子を移植するのは特に抵抗無いです。
