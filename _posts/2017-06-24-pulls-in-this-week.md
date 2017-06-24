---
layout: post
title: "JSAnywhere 4で使うために送ったPR達"
categories: misc
---

[Use isReachableViaWiFi instead of isReachableViaWiFi() on README.md by tnantoka · Pull Request #206 · ashleymills/Reachability.swift](https://github.com/ashleymills/Reachability.swift/pull/206)  
これはだいぶ前のですが、READMEのタイポを修正。

[Fix shareFilesFromDirectory with percent encoded path by tnantoka · Pull Request #249 · httpswift/swifter](https://github.com/httpswift/swifter/pull/249)  
ファイル名にスペースを含む静的ファイルが見れなかったのを修正。修正方法にあまり自信がないのでマージされるか不安。

[CodeAttributedString with auto detection by tnantoka · Pull Request #17 · raspu/Highlightr](https://github.com/raspu/Highlightr/pull/17)  
シンタックスハイライトのライブラリ。言語の自動検出機能がUITextViewで使えなかったので修正。
このライブラリを使うかはまだ未定。今後の細かい修正などを考えると、やはり自前でNSTextStorageなど書いたほうがいいのかもしれません。
