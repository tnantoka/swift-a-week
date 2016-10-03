---
layout: post
title: "SKFieldNodeでシャボン玉のような動き"
categories: example
---

諸事情でシャボン玉っぽい動きをやる必要が出てきたので、SpriteKitの`SKFieldNode.noiseField(withSmoothness:animationSpeed:)`を試してみました。

![](/images/posts/bubble-with-sk-field-node/bubble.gif)

あまりシャボン玉には見えませんが、この手軽さはありがたいです。

## 参考　

- [\[Swift]] SKFieldNode Noise Field. 不規則な方向に揺らす。 \| はじはじアプリ体験記](http://hajihaji-lemon.com/smartphone/swift/spritekit-noise-field/)
- [SpriteKitで場を作る事のできるクラス、SKFieldNodeを試す - しめ鯖日記](http://llcc.hatenablog.com/entry/2015/09/24/232103)

## ソースコード

<https://github.com/tnantoka/swift-a-week/tree/gh-pages/works/Bubble>
