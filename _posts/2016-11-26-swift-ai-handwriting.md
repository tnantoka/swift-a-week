---
layout: post
title: "Swift AIのExamplesから手書き認識の部分だけ持ってくる"
categories: example
---

指で書いた数字を認識する機能の実装が必要になりました。
以下の記事を読んだことがあり、[collinhundley/Swift-AI](https://github.com/collinhundley/Swift-AI)でできそうだということがわかっていたので、まずはExamplesから必要な部分だけを取り出してみました。

[Swiftで書かれた人工知能・機械学習ライブラリ「Swift-AI」をiOSで動かしてみる - Over&amp;Out その後](http://d.hatena.ne.jp/shu223/20160124/1453597136)

以下のファイルをプロジェクトにコピーして、Info.plistにフォント関連の記述を追加したら動きました。

- APBorderView.swift
- APConstraints.swift
- APMath.swift
- APMultilineLabel.swift
- APSpringButton.swift
- Colors.swift
- FFNN+Storage.swift
- FFNN.swift
- Fonts.swift
- HandwritingView.swift
- HandwritingViewController.swift
- OpenSans-Bold.ttf
- OpenSans-Italic.ttf
- OpenSans-Light.ttf
- OpenSans-LightItalic.ttf
- OpenSans-Semibold.ttf
- OpenSans.ttf
- Storage.swift
- handwriting-ffnn
- white.imageset

{% highlight xml %}
  <key>UIAppFonts</key>
  <array>
    <string>OpenSans.ttf</string>
    <string>OpenSans-Bold.ttf</string>
    <string>OpenSans-Semibold.ttf</string>
    <string>OpenSans-Light.ttf</string>
    <string>OpenSans-Italic.ttf</string>
    <string>OpenSans-LightItalic.ttf</string>
  </array>
{% endhighlight %}

今回はSwift-AIでやってみましたが、[TensorSwift](http://qiita.com/koher/items/2c0bfca4d6e31cde674b)でも手軽にできそうだったので、機会があればこちらも使ってみようと思います。

iOS 10以降であれば、[MPSCNNHelloWorld](https://developer.apple.com/library/content/samplecode/MPSCNNHelloWorld/Introduction/Intro.html)を参考に標準機能だけでできそうなのですが、Metalはシミュレータで動作せず実機での開発になるため、今回は遠慮しておきました。
 
## 参考

- [540667209/Swift-AI](https://github.com/540667209/Swift-AI) Swift 3でそのまま動く状態に修正されていました。ありがたいです。
- [swift3はじめました！\｜Appleの手書き数字認識サンプルコードが面白かったので遊んでみました](http://hikaruapp.jpn.com/xcode/post-1466)
- [iOS 10の新機能のサンプルコード集「iOS-10-Sampler」を公開しました - Over&amp;Out その後](http://d.hatena.ne.jp/shu223/20160914/1473808485)

## ソースコード

<https://github.com/tnantoka/swift-a-week/tree/gh-pages/works/SwiftAIHandwriting>
