---
layout: post
title:  "Hello C4 その4: Shapeを光らせたい"
categories: example
---

[C4](https://github.com/C4Framework/C4iOS)のShapeを光らせようと格闘していました。

単純にShadowを指定するとこうなってしまいます。
![](/images/posts/glow-shape-with-c4/shadow.png)

[Inner Shadows in Quartz](http://blog.helftone.com/demystifying-inner-shadows-in-quartz/)を参考にすることで、Fillせずに影をつけることができました。

![](/images/posts/glow-shape-with-c4/glow1.png)

そして、[FBGlowLabel](https://github.com/lyokato/FBGlowLabel)のように線の中にも影をつけてみました。

![](/images/posts/glow-shape-with-c4/glow2.png)

最終的にC4はあんまり関係なくなりましたが、なんとかなりそうでよかったです。
（試行錯誤しているうちにソースがひどいことになってしまったので、リファクタリングが必要ですが…。）

## ソースコード

<https://github.com/tnantoka/swift-a-week/tree/gh-pages/works/HelloC4/C4Glow.playground>

