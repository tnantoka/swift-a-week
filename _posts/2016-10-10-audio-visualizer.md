---
layout: post
title: "音に合わせてSprite Kitのパーティクルを動かす"
categories: example
---

[AudioKit](https://github.com/audiokit/AudioKit)などで行われているガチな方法じゃなくて、AVAudioPlayerを使う簡易的な実装です。

一応、ある程度以上の音がなっている時にパーティクルを爆発させるようにしています。
ですが、そんなに精度はよくなく、なんとなく音楽に合ってるかなぁ、ぐらいの感じです。　

![](/images/posts/audio-visualizer/particle.gif)

## 素材

- [『ファンタジー04』無料・フリー高音質BGM音楽素材/魔王魂](http://maoudamashii.jokersounds.com/archives/bgm_maoudamashii_fantasy04.html)

## 参考　

- [How To Make a Music Visualizer in iOS](http://www.raywenderlich.com/36475/how-to-make-a-music-visualizer-in-ios)
- [ooper-shlab/avTouch1.4.3-Swift: A translation of Apple's sample code avTouch into Swift](https://github.com/ooper-shlab/avTouch1.4.3-Swift)

## ソースコード

<https://github.com/tnantoka/swift-a-week/tree/gh-pages/works/AudioVisualizer>
