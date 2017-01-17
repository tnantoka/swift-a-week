---
layout: post
title: "Swift 3にあげたらsrand()が使えなくなった"
categories: tips
---

[tnantoka/generative-swift](https://github.com/tnantoka/generative-swift)をSwift 3化しようと作業していたところ、

> 'srand' is unavailable in Swift: Use arc4random instead.

というエラーに遭遇しました。
seedを変更するまでは一定のランダムを得たい箇所だったので`arc4random`は使えません。

`srand48`と`drand48`は使えたのでそちらに変更しました。

{% highlight swift %}
if rand() % 2 == 0 {
{% endhighlight %}

としてたところは、

{% highlight swift %}
if drand48() > 0.5 {
{% endhighlight %}

のように変更しました。(50%ずつの確率で分岐したいだけだったので）

## ソースコード

- <https://github.com/tnantoka/generative-swift>
