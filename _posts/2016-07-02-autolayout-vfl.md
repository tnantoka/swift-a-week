---
layout: post
title:  "AutoLayoutのVFLだけで書けなかった単純なレイアウト"
categories: tips
---

僕は長い間、StoryboardとAutoLayoutをあまり触らずに来て、昨年ぐらいからようやくまともに使うようになりました。
Storyboardの方が楽な場面があるのはわかるのですが、やはりコードで書くほうが性に合っていそうです。
しかし、AutoLayoutの便利さは今更手放せません。

というわけで、最近はコードでAutoLayoutを書いています。

AutoLayoutをコードで書く方法は、 `NSLayoutConstraint` の `init(item:attribute:relatedBy:toItem:attribute:multiplier:constant:)` を使う方法と、 `constraintsWithVisualFormat(_:options:metrics:views:)` を使う方法の2種類があります。

後者がVFL(Visual Format Language)と呼ばれ、記述が短くなり後から読み返しやすいので、できればこちらで書きたいところです。
ですが、VFLだけだと書けない制約があり、たまに困ることがあります。

今回は以下の様なレイアウトを実現したくて、結局通常の書き方も組み合わせて実装しました。

![](/images/posts/autolayout-vfl/example.png)

VFL出かけなかったのは次の2点です。

1. imageViewを可変するwidthに合わせて正方形にする
1. labelの高さを中身に合わせて変えつつ、下部にスペースを開ける

僕のAutoLayout力が低いだけで、実はあっさり書く方法があるのかもしれませんが…。
こういう困りごともありますが、やはりコードで書いた方が頭の中がすっきりする気がします。　

## ソースコード

<https://github.com/tnantoka/swift-a-week/tree/gh-pages/works/VFL.playground>


## 参考

- [Auto Layoutをコードから使おう](http://blog.personal-factory.com/2016/01/11/make-auto-layout-via-code/)
- [VFLを使ってみよう](http://blog.personal-factory.com/2016/01/16/use-visual-format-language-with-auto-layout/)
