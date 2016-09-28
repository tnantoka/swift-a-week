---
layout: post
title: "IconCreatorをSwift 3化"
categories: tips
---

自分が作ったSwiftのプログラムで一番使ってるかもしれない、<https://github.com/tnantoka/IconCreator> をXcode 8で動くようにしました。

- `UIColor.whiteColor()`の`Color()`部分などを削除
- `NS`プレフィックスを削除
- enumが小文字始まりに
- CoreGraphicsのAPI変更（~MakeやCGContextAdd~系の廃止など）
- PDF生成の修正（closePDF呼ばないと壊れるようになっていた）

PDFのところ以外はほぼ自動時間でいけました。Xcodeは優秀ですね。

## 参考　

[[SR-1828] CGContext.endPage() is ambiguous - Swift](https://bugs.swift.org/browse/SR-1828)
