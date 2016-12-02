---
layout: post
title: "Swift AIのExamplesから手書き認識の部分だけ持ってくる その2"
categories: example
---

[前回](/example/2016/11/26/swift-ai-handwriting.html)はとりあえず動かすことを目的に、結構な数のファイルを[Swift-AI](https://github.com/collinhundley/Swift-AI)から持ってきましたが、少し手を加えればだいぶ減らせそうだったのでやってみました。

結果、以下の6ファイルになりました。

- FFNN+Storage.swift
- FFNN.swift
- HandwritingView.swift
- HandwritingViewController.swift
- Storage.swift
- handwriting-ffnn

数字の手書き認識部分を使うだけなら、これで簡単にできそうです。

## ソースコード

<https://github.com/tnantoka/swift-a-week/tree/gh-pages/works/SwiftAIHandwriting>
