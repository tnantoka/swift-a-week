---
layout: post
title:  "サーバサイドSwiftで静的なHTMLを返すだけのシンプルなサイトを作る"
categories: tips
---

サーバサイドSwiftで、http://www.serversideswift.net/ というサイトを作っています。(公開終了) 
ローカルでのテストを終えていざ公開、となった時にいくつかエラーに遭遇したので、そのメモです。

## Killed

{% highlight sh %}
<unknown>:0: error: unable to execute command: Killed
{% endhighlight %}

これは単にSwiftがbuild時に複数プロセスでメモリを食いまくるのでKillされてただけでした。
Swapを追加したら解消しました。
https://www.digitalocean.com/community/tutorials/how-to-add-swap-on-ubuntu-14-04

## has no member

OS Xでは動いてるのに、同じソースがLinuxで動かないパターンです。
一番困ったのはNSFileManagerで、結局`#if`を使ってOSで分岐して逃げました。

{% highlight sh %}
error: value of type 'NSFileManager' has no member 'fileExists'
{% endhighlight %}

{% highlight swift %}
#if os(Linux)
    NSFileManager.defaultManager().fileExistsAtPath(path)
#else
    NSFileManager.defaultManager().fileExists(atPath: path)
#endif
{% endhighlight %}

## multiple definition of `main'

`main.swift`があるパッケージをテストしようとすると、`LinuxMain.swift`で以下のようなエラーになってしまいました。　

{% highlight sh %}
/serversideswift.net/Sources/SSS/main.swift:(.text+0x0): multiple definition of `main'
/serversideswift.net/Tests/LinuxMain.swift:(.text+0x0): first defined here
{% endhighlight %}

Vaporを参考に（VaporDevというmain.swiftを持つターゲットがある）、mainを別ターゲットに分けることで対応しました。

{% highlight swift %}
targets: [
    Target(
        name: "SSS"
    ),
    Target(
        name: "SSSMain",
        dependencies: [
            .Target(name: "SSS")
        ]
    )
]
{% endhighlight %}

Package.swiftをこのように書き換えて、main.swiftをSSSMainに置きました。

もう最初からLinuxで開発した方がいいかも、という気になってきました。
（OS Xでサーバ稼働させることはあまりないでしょうし…）
