---
layout: post
title: "Hello, SceneKit"
categories: example
---

ずっと触りたいと思いつつ触れてなかったSceneKitにようやく手を出しました。

![](/images/posts/hello-scene-kit/box.png)

まずはSingle View Applicationから始めて、Boxを表示するところまで。

ライトは`autoenablesDefaultLighting`で充分だったのでそれを使いました。  
カメラはデフォルトのものの位置変更の方法がわからなかったので自分で追加しました。  
また、背景色を設定しないと白になってしまったので、そちらも設定しています。  

## 参考　

- [Swift + Playgraoundメモ 3 – SceneKitで3Dライブコーディング！ \| yoppa org](http://yoppa.org/blog/5496.html)
- [SceneKitに触れてみる（2） - 工場裏のアーカイブス](http://chemicalfactory.hatenablog.com/entry/2015/01/24/020746)

## ソースコード

<https://github.com/tnantoka/swift-a-week/tree/gh-pages/works/HelloSceneKit>
