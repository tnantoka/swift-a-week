---
layout: post
title:  "[番外編] Hello, React Native"
categories: example
---

今回はSwiftよりJavaScriptをたくさん書く、番外編です。 

興味が湧いたのでReact Nativeを触ってみました。

<table cellpadding="0" cellspacing="0" border="0" style=" border-style: none; width:170px;"><tr style="border-style:none;"><td style="vertical-align:top; border-style:none; padding:10px;"><a href="http://px.a8.net/svt/ejp?a8mat=1NWF4Y+EFRJQY+249K+BWGDT&a8ejpredirect=http%3A%2F%2Fwww.amazon.co.jp%2Fdp%2F1484213963%2F%3Ftag%3Da8-affi-255514-22" target="_blank"><img border="0" alt="" src="http://ecx.images-amazon.com/images/I/41X5Gf7eh6L._SS160_.jpg" /></a></td></tr></table>
<img border="0" width="1" height="1" src="http://www14.a8.net/0.gif?a8mat=1NWF4Y+EFRJQY+249K+BWGDT" alt="">
[React Native for iOS Development](http://px.a8.net/svt/ejp?a8mat=1NWF4Y+EFRJQY+249K+BWGDT&a8ejpredirect=http%3A%2F%2Fwww.amazon.co.jp%2Fdp%2F1484213963%2F%3Ftag%3Da8-affi-255514-22)

手始めに、この本の前半部分を読んでHello Worldを作成しました。

## メモ 

### インストール

{% highlight sh %}
$ curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.31.1/install.sh | bash
$ nvm install v4.4.4
$ nvm alias default v4.4.4
$ node -v
v4.4.4

$ npm -v
3.3.6

# https://facebook.github.io/react-native/docs/getting-started.html#highly-recommended-installs
$ brew install watchman

$ npm install -g react-native-cli
$ react-native --version
react-native-cli: 0.2.0
react-native: 0.25.1
{% endhighlight %}

### プロジェクト作成

{% highlight sh %}
$ react-native init HelloWorld
$ cd HelloWorld/

$ react-native run-ios

$ open ios/HelloWorld.xcodeproj/
{% endhighlight %}

### よく使うコマンド

- Command + R: リロード
- Command + D: デバッグ関連のメニュー表示

### ES2015

{% highlight js %}
AppRegistry.registerComponent('HelloWorld', () => HelloWorld);
{% endhighlight %}

returnを省略する書き方を知らなかったのです。

<https://developer.mozilla.org/ja/docs/Web/JavaScript/Reference/arrow_functions>

試行錯誤の結果、こういうものができました。

![](/images/posts/hello-react-native/home.png)

## 参考

- [Reactの単純なサンプルでFluxの実装を解説 mae's blog](http://mae.chab.in/archives/2747) 
- [Tutorial: Custom React Native Components in Swift](http://kevin-deleon.com/2015/05/custom-react-native-components-in-swift/) 

<!--

<table cellpadding="0" cellspacing="0" border="0" style=" border-style: none; width:170px;"><tr style="border-style:none;"><td style="vertical-align:top; border-style:none; padding:10px;"><a href="http://px.a8.net/svt/ejp?a8mat=1NWF4Y+EFRJQY+249K+BWGDT&a8ejpredirect=http%3A%2F%2Fwww.amazon.co.jp%2Fdp%2F1785885189%2F%3Ftag%3Da8-affi-255514-22" target="_blank"><img border="0" alt="" src="http://ecx.images-amazon.com/images/I/511mWmIlMSL._SS160_.jpg" /></a></td></tr></table>
<img border="0" width="1" height="1" src="http://www15.a8.net/0.gif?a8mat=1NWF4Y+EFRJQY+249K+BWGDT" alt="">
[Getting Started With React Native](http://px.a8.net/svt/ejp?a8mat=1NWF4Y+EFRJQY+249K+BWGDT&a8ejpredirect=http%3A%2F%2Fwww.amazon.co.jp%2Fdp%2F1785885189%2F%3Ftag%3Da8-affi-255514-22)

<table cellpadding="0" cellspacing="0" border="0" style=" border-style: none; width:170px;"><tr style="border-style:none;"><td style="vertical-align:top; border-style:none; padding:10px;"><a href="http://px.a8.net/svt/ejp?a8mat=1NWF4Y+EFRJQY+249K+BWGDT&a8ejpredirect=http%3A%2F%2Fwww.amazon.co.jp%2Fdp%2FB018WODRKK%2F%3Ftag%3Da8-affi-255514-22" target="_blank"><img border="0" alt="" src="http://ecx.images-amazon.com/images/I/51nVfYng1gL._SS160_.jpg" /></a></td></tr></table>
<img border="0" width="1" height="1" src="http://www12.a8.net/0.gif?a8mat=1NWF4Y+EFRJQY+249K+BWGDT" alt="">
[Learning React Native: Building Native Mobile Apps with JavaScript](http://px.a8.net/svt/ejp?a8mat=1NWF4Y+EFRJQY+249K+BWGDT&a8ejpredirect=http%3A%2F%2Fwww.amazon.co.jp%2Fdp%2FB018WODRKK%2F%3Ftag%3Da8-affi-255514-22)
-->

## ソースコード

<https://github.com/tnantoka/swift-a-week/tree/gh-pages/works/HelloReactNative>

