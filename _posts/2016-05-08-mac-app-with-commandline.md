---
layout: post
title:  "コマンドラインでMacアプリを作る"
categories: example
---

参考記事を見ながらステータスバーにメニューを表示するところまでやってみました。

{% highlight sh %}
$ swift HelloSwift.swift
{% endhighlight %}

でとりあえず動くはずです。
しかし、Cocoa触るの久しぶりすぎて完全に忘れていました…。

全部コマンドラインでやりましたがやはり入力補完とかないと辛いので次からはXcodeでやろうと思います。
（ちゃんと動くステータスバーアプリを作ってみたい）

## 参考

- [Single-file Cocoa application with Swift – Łukasz Adamczak](http://czak.pl/2015/09/23/single-file-cocoa-app-with-swift.html)
- [Cocoa programming in the terminal with Swift 2.0 – Swift development blog](http://mhorga.org/2015/07/25/cocoa-programming-in-the-terminal-with-swift-2.html)
- [How to write a minimal WebKit browser in 30 lines of Swift \| practicalswift.com](http://web.archive.org/web/20160123002831/http://practicalswift.com/2014/06/27/a-minimal-webkit-browser-in-30-lines-of-swift/)

## ソースコード

<https://github.com/tnantoka/swift-a-week/tree/gh-pages/works/MinimalCocoaApps/HelloWorld.swift>

