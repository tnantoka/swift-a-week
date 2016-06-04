---
layout: post
title:  "APSpeechSynthesizerで読み上げ"
categories: example
---

次作るアプリで読み上げ機能が欲しいなと思いAPSpeechSynthesizerを触ってみました。
せっかくなのでPlaygroundで。ただ実行されるたびに読み上げられると困るのでInteractive Playgroundにしてボタンをタップした時に読み上げるようにしました。

お手軽でいいですね。
日本語でpitchを2.0にした時の声がなんか怖くて苦手でした…。

## ソースコード

<https://github.com/tnantoka/swift-a-week/tree/gh-pages/works/AVSpeechSynthesizer.playground>

## 参考

- [AVSpeechUtterance Class Reference](https://developer.apple.com/library/ios/documentation/AVFoundation/Reference/AVSpeechUtterance_Ref/)
- [みんな大好き`AVSpeechSynthsizer`について - Qiita](http://qiita.com/ushisantoasobu/items/569e04b3dd49826c797f)  
- [Playground でオーディオ再生（音声読みあげ）をする - ObjecTips](http://koze.hatenablog.jp/entry/2016/04/08/090000)

