---
layout: post
title: "PixelMplusフォントをCocoaPods化"
categories: library
---

いわゆるファミコン風フォントはたくさんありますが、[PixelMplus（ピクセル・エムプラス） ‥ 8bitビットマップふうフリーフォント - itouhiroはてなブログ](http://itouhiro.hatenablog.com/entry/20130602/font) がライセンス含めて使いやすく、お気に入りです。

iOSでカスタムフォントを使うのは、ファイルをプロジェクトに追加して、`Info.plist`に`Fonts provided by application`を追加するだけなんですが、「あれ？正式なフォント名なんだったけ？」とかなったりするので、Podfileに1行書けば使えるようにしてみました。

ゲーム開発などの際に使っていこうと思います。

## ソースコード

<https://github.com/tnantoka/PixelMplus>
