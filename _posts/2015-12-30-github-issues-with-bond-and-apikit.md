---
layout: post
title:  "BondとAPIKitを使ってGitHubのIssuesを一覧表示"
categories: example
---

今申請中のアプリで、遅ればせながらSwiftBondを使ってみたら、大変お手軽で気に入りました。

[README](https://github.com/SwiftBond/Bond#readme)に、以下のような記述があって気になりますが、[非推奨というわけではない](https://github.com/SwiftBond/Bond/issues/200)ようです。

> Note: If you're looking into starting a new project with Bond, please check out ReactiveKit framework instead. ReactiveKit is Bond's successor that brings better performance, cleaner API and additional features in less lines of code.

ということで、もっとBondに慣れるべく、[APIKit](https://github.com/ishkawa/APIKit)、[Himotoki](https://github.com/ikesyo/Himotoki)と組み合わせてGitHubのIssues一覧を作ってみました。

## スクリーンショット

![](/images/posts/github-issues-with-bond-and-apikit/signed-out.png)

![](/images/posts/github-issues-with-bond-and-apikit/signed-in.png)

![](/images/posts/github-issues-with-bond-and-apikit/issues.png)

![](/images/posts/github-issues-with-bond-and-apikit/web.png)

## やったこと

1. GitHubから、UserとIssuesを取得（APIKit）
2. APIの結果をModelにマッピング（Himotoki）
3. ViewModelを作成し、各情報をViewにbind（Bond） 

## 課題

- ページネーションをProtocol Extensionで書きたい
- TableViewのヘッダーを綺麗に書く方法
- ログイン直後にボタンのenabledが反映されない（main_queueでやればOKだった）

## 感想

まだ慣れてないので時間がかかる部分はありますが、各ライブラリのおかげで少ないコード量で実装できました。
このような構成で、ちゃんとしたアプリを1本つくってみたいところです。

## ソースコード

<https://github.com/tnantoka/swift-a-week/tree/gh-pages/works/GitHubIssuesWithBond>

## 参考

- [bricklife/ReactKit-APIKit-Himotoki-sample](https://github.com/bricklife/ReactKit-APIKit-Himotoki-sample)
- [Swift で ConoHa API に APIKit と Himotoki を使って接続してみる。](https://ez-net.jp/article/29/Oq3LtahN/DYYKiC3ifJlW/)
- [Swift 2でのAPIKit + Himotoki](http://blog.ishkawa.org/2015/07/29/1438165961/)
- [SwiftBond/Bond-Demo-App](https://github.com/SwiftBond/Bond-Demo-App)


