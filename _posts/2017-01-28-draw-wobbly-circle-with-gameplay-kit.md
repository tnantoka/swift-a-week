---
layout: post
title: "GKNoiseを使って手書き風の円を描く"
categories: tips
---

パーリンノイズを使えば、手書き風の円を描くことができることを知りました。
そして、GameplayKitでは簡単にパーリンノイズを使えます。

### パーリンノイズを使った例

![](/images/posts/draw-wobbly-circle-with-gameplay-kit/perlin.png)

### ランダムを使った例

![](/images/posts/draw-wobbly-circle-with-gameplay-kit/random.png)

ランダムの方は多少いじってみたところで、やはり不自然です。
パーリンノイズ、便利ですね。

## ソースコード

<https://github.com/tnantoka/swift-a-week/blob/gh-pages/works/WobblyCircle.playground>
