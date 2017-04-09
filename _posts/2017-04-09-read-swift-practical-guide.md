---
layout: post
title:  "Swift実践入門を読んだメモ"
categories: book
---

ようやく目を通すことができたので、メモを残しておきます。

<table cellpadding="0" cellspacing="0" border="0" style=" border-style: none; width:170px;"><tr style="border-style:none;"><td style="vertical-align:top; border-style:none; padding:10px 10px 0pt; width:140px;"><a href="https://px.a8.net/svt/ejp?a8mat=1NWF4Y+EFRJQY+249K+BWGDT&a8ejpredirect=https%3A%2F%2Fwww.amazon.co.jp%2Fdp%2F4774187305%2F%3Ftag%3Da8-affi-255514-22" target="_blank" rel="nofollow"><img border="0" alt="" src="https://images-fe.ssl-images-amazon.com/images/I/51O5F5tHiuL._SS160_.jpg" /></a></td></tr><tr style="border-style:none;"><td style="font-size:12px; vertical-align:middle; border-style:none; padding:10px;"><p style="padding:0; margin:0;"><a href="https://px.a8.net/svt/ejp?a8mat=1NWF4Y+EFRJQY+249K+BWGDT&a8ejpredirect=https%3A%2F%2Fwww.amazon.co.jp%2Fdp%2F4774187305%2F%3Ftag%3Da8-affi-255514-22" target="_blank" rel="nofollow">Swift実践入門 ── 直感的な文法と安全性を兼ね備えた言語 (WEB DB PRESS plus)</a></p></td></tr></table>

ページ | メモ
-- | --
p. 4 |  `max(_:_:)`という関数名の書き方すぐ忘れるので覚えておこう
p. 36 | CGFloat型はFloat型のエイリアス？CLLocationDegreesは`public typealias CLLocationDegrees = Double`になってたけど、CGFloatは`public struct CGFloat {`で定義されてるので違いそう。
p. 88 | switchのdefaultはenumのcaseを増やした時に実装漏れの可能性などがあるので、できるだけ使わない。
p. 91 | for case知らなかった
p. 100 | `~=`知らなかった
p. 103 | is忘れがち
p. 108 | `@discardableResult`知らなかった
p. 118 | `() -> ()`じゃなく`() -> Void`と書く # TODO
p. 119 | doでスコープ作る（catchと組み合わせなくても使える）
p. 123 | `@autoclosure`の説明わかりやすい。`or(lhs(), rhs())`でrhsがclosureになってないとlhsがtrueでもrhsが実行されちゃう。それを自動で。
p. 155 | UIAlertControllerに独自エラー渡すの便利そう。
p. 156 | Prefixつけるより、型をネストする # TODO
p. 168 | メンバーワイズイニシャライザっていうのか、Structに自動定義されるやつ。
p. 176 | サブクラスで変更する→クラスプロパティ・メソッド、変更しない→スタティックプロパティ・メソッド
p. 252 | クラスを利用すべき時：参照を共通（Targetを登録して通知を受ける）、ライフサイクルに合わせた処理（deinitでファイル破棄）
p. 258 | 継承を利用すべき時：ストアドプロパティを複数の型で共有
p. 264 | ImplicitlyUnwrappedOptionalの使いどころ：最初nilが入るけどそれ以降は絶対入らない(Optionalだとnilが入ってくる仕様に誤解される)、サブクラスの初期化より前に親クラスを初期化したい
p. 268 | 不正な状態でもできるだけ動いてほしいならOptional
p. 275 | delegateを使うべき時：多数のイベント通知がある
p. 282 | weakとunowned。nilにならないならunownedでいい。nilにならない仕様を明確化できる。でも結局weakの方が安全か。# TODO
p. 284 | escapingなクロージャはself必須、循環参照に気づきやすいメリットある
p. 285 | クロージャを使うべき時：処理の実行とコールバックを同じ場所に書きたい
p. 289 | オブサーバを使うべき時：1対多の通知
p. 306 | Threadを使うべき時：特になしw
p. 313 | エラー処理にOptionalを使うべき時：値の有無だけで十分
p. 316 | エラー処理にResultを使うべき時：エラーの詳細を知りたい、成功か失敗いずれかを保証、非同期処理
p. 319 | `case error(String)`じゃなく`case error(reason: String)`わかりやすい # TODO
p. 322 | rethrows知らなかった
p. 343 | アサーションはデバッグの時だけ。fatalErrorはReleaseでも落ちる。
p. 396 | Objective-Cの新機能（ライトウェイトジェネリクス、null許容性アノテーションなど）

1つ1つの章がコンパクトにまとまっていて読みやすかったです。
まだあまり手は動かせてないので、今あるコードに適用できそうなところは取り入れて行きたいと思います。（# TODOつけたところなど）
