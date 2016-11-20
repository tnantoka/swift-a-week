---
layout: post
title: "StringFilterをSwift 3化して、VaporでLive Exampleサイトを作る"
categories: library
---

## StringFilterをSwift 3に以降

主にやった作業は以下のようなものです。最後のが一番大変でした。

- XcodeでソースをConvert、プロジェクト設定も推奨状態に
- テストの実行環境を`iPhone 6s, 9.2`から`iPhone 7, 10.1`に変更
- [swiftenv-install.sh](https://gist.github.com/kylef/5c0475ff02b7c7671d2a/)を最新化
- [https://github.com/vapor/vapor/tree/master/Tests](Vaporのテスト)を参考にLinuxのテストを修正
- macOSとLinuxで標準APIに差のある部分を`#if os(Linux)`で分岐

## Live Exampleサイトの作成

[前回の記事](/example/2016/11/11/vapor-long-time-no-see.html)と同じようにVaporで簡単なWebアプリを作りました。

肝心のStringFilterですが、`Package.swift`に、

{% highlight swift %}
.Package(url: "https://github.com/tnantoka/StringFilter.git", majorVersion: 0, minor: 0),
{% endhighlight %}

を追加したら素直に動いてくれて、特にハマりどころはありませんでした。

## Herokuで公開

これもVapor Toolboxのコマンドで一発でした。

### 事前準備

{% highlight sh %}
# https://devcenter.heroku.com/articles/heroku-command-line

$ heroku --version
heroku-toolbelt/3.43.14 (x86_64-darwin10.8.0) ruby/1.9.3
heroku-cli/5.5.1-cf2de15 (darwin-amd64) go1.7.3
You have no installed plugins.

$ heroku login
{% endhighlight %}

### 事前準備

{% highlight sh %}
$ vapor heroku init
Would you like to provide a custom Heroku app name?
y/n>y
Custom app name:
>stringfilter
https://stringfilter.herokuapp.com/ | https://git.heroku.com/stringfilter.git

Would you like to provide a custom Heroku buildpack?
y/n>n
Setting buildpack...
Are you using a custom Executable name?
y/n>n
Setting procfile...
Committing procfile...
Would you like to push to Heroku now?
y/n>y
This may take a while...
Building on Heroku ... ~5-10 minutes [Done]
Spinning up dynos [Done]
Visit https://dashboard.heroku.com/apps/
App is live on Heroku, visit 
https://stringfilter.herokuapp.com/ | https://git.heroku.com/stringfilter.git
{% endhighlight %}

<https://stringfilter.herokuapp.com/>にアクセスすることで、実際にStringFilterの挙動を試してみることができます。  
サーバーサイドSwiftの使い方の1つとして、わりと実用的ではないかと思っています。

## 参考

- [Heroku に Vapor をデプロイする \| digitrick Notes](http://dev.digitrick.us/notes/VaporOnHeroku)

## ソースコード

<https://github.com/tnantoka/StringFilterExample>
