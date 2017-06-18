---
layout: post
title: "UISplitViewControllerとAdMobの組み合わせて困ったところ"
categories: tips
---

SplitViewControllerはiPhoneのPlus系（5.5インチ）のLandscapeではiPadのLandscapeと同じく、左にTableViewが出る分割スタイルになります。

この状態で、`kGADAdSizeSmartBannerLandscape`を使うと広告のクリックができないようでした。

Portraitサイズの広告なら問題なさそうだったので、ひとまずそちらを使うことにしましたが、
高さが少し大きくて困るのでちゃんと解決したいところです。
