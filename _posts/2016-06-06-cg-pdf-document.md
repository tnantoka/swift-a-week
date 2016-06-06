---
layout: post
title:  "CGPDFDocumentでPDFを表示"
categories: example
---

PDF Viewer用のライブラリはたくさんあるんですが、どれもがっつりしてて、ちょっと中身を表示したいだけの用途には大袈裟な感じがしたので、`CGPDFDocument`系の機能を試してみました。
表示するだけなら思ったより簡単でした。

`CGPDFDocumentGetPage`に与えるのはindexではなくpageNumberなので1始まりです。

## ソースコード

<https://github.com/tnantoka/swift-a-week/tree/gh-pages/works/PDF/PDF.playground>

## 参考

- [ZoomingPDFViewer](https://developer.apple.com/library/ios/samplecode/ZoomingPDFViewer/Introduction/Intro.html#//apple_ref/doc/uid/DTS40010281) 

