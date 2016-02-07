---
layout: post
title:  "Functional Swiftを読む その1"
categories: book
---

存在は知っていて、いつか読まなきゃと思ってたんだけど、ようやく時間を取れました。

<table cellpadding="0" cellspacing="0" border="0" style=" border-style: none; width:170px;"><tr style="border-style:none;"><td style="vertical-align:top; border-style:none; padding:10px;"><a href="http://px.a8.net/svt/ejp?a8mat=1NWF4Y+EFRJQY+249K+BWGDT&a8ejpredirect=http%3A%2F%2Fwww.amazon.co.jp%2Fdp%2FB00UY3K04O%2F%3Ftag%3Da8-affi-255514-22" target="_blank"><img border="0" alt="" src="http://ecx.images-amazon.com/images/I/31rBSsCp5GL._SS160_.jpg" /></a></td></tr><tr style="border-style:none;"></tr></table>
<img border="0" width="1" height="1" src="http://www12.a8.net/0.gif?a8mat=1NWF4Y+EFRJQY+249K+BWGDT" alt="">
ちなみに、正式なタイトルはFunctional Programming in Swiftでなく、**Functional Swift**のようです。  
今回読んだのは`2015-12-14`版です。

<http://egg-is-world.com/2015/09/09/sugoi-haskell-book/>を見て、先に[すごいHaskellたのしく学ぼう!](http://px.a8.net/svt/ejp?a8mat=1NWF4Y+EFRJQY+249K+BWGDT&a8ejpredirect=http%3A%2F%2Fwww.amazon.co.jp%2Fdp%2F4274068854%2F%3Ftag%3Da8-affi-255514-22)を読んだんですが大正解でした。  
関数型の用語とか知らない状態だと、特に後半がきつかったと思われます。  
全体的にHaskellを参考にされてる部分も多く、この話すごいHaskell本で見たことあるぞ？という感じで理解の助けになりました。

以下この本を読んだ記録です。

## 1回目

この本は1回で理解できない覚悟をしていたので、まずはキーボードを触らずに読みました。
途中までは調子良かったですが、12章辺りからこれ手を動かさないと無理だな、となりました。
一応全体の流れをつかむために最後まで流しました。

我ながらひどいですが、こんなメモが残っておりました。  
（読みながらiPhoneで書いたもの。ページはPDF版のものです。）

ページ | メモ
-- | --
p. 30 | CIImageのFilterの例はimage引数がcurry化されてる。初めてcurry化がしっくりきたかも。
p. 41 | reduceはfoldlと同じ。
p. 45 | ->A->B->Cはどういう意味？
p. 51 | precedence触ってみる。自分で演算子定義すること少ないから忘れがち。
p. 55 | なぜmapと呼ぶかはお楽しみ。
p. 67 | こういう時はforでいいんだよという例。
p. 71 | guardにbool直接渡すの使っていこう。
p. 72 | Arrayを直接Arbitraryに適合させられないので、ArbitraryInstanceが必要。
p. 84 | mutable使っても問題ないケースもあるよねという例。関数外に影響がない。
p. 88 | バッククォートは何？
p. 91 | Eitherのわかりやすい例。
p. 99 | indirectとは？
p. 100 | let .っていう書き方使ったことなかった。
p. 101 | if caseも使ったことなかった。
p. 107 | decomposeいい感じ。他のコードでも使えそう。
p. 112 | GitHubのサンプル動かす。10章を参考に何か作りたい。
p. 133 | mutatingが必要。
p. 134 | AnyGenerator触ってみる。
p. 137 | noescape忘れがち。
p. 139 | oneとArray、+の使い方。
p. 156 | pure。この章からはコードが多くて手を動かさないとついていけなさそう。
p. 187 | なぜmapっていう同じ名前持ってる？ArrayもOptinalもType constructors。（Haskellの型コンストラクタ）
p. 188 | Functorはよくcontainerと言われるけどRegionみたいなのもFunctor。
p. 191 | addOptinalsの例いい。[...]ってなんだ？ただの省略か。
p. 192 | Monadsの説明良い。
p. 194 | list comprehensions？内包表記のことだった。
p. 197 | よいまとめ。
p. 198 | Haskellやりましょうという話。

## 2回目

2回目は理解を深めるため、1回目に気になった部分をPlaygroundで試しながら読みました。
（ところどころすごいHaskell本も参照しながら…）

結果はこちらです。

<https://github.com/tnantoka/swift-a-week/blob/gh-pages/works/FunctionalSwift.playground/Contents.swift>

`StringFilter`は、第3章を参考にStringの変換を関数型っぽくしてみたものです。  　
変換対象である`string`がcurry化されていると考えると、しっくりきました。

`GeneratorOfOne`は、Optionalとそうじゃない型を簡単にGeneratorにできることはわかったけど、
まだ自分のコード内で使えるレベルにはなってないです。

まだ理解しきったとは言えないので3回目も読もうと思います。（特に12章以降）  
投稿が遅れた上に、今週はアウトプットの少ない週でした。

## 宿題

1. 10章を参考に何かを作る
2. 12章のParserを写経
3. Functor、Applicative、Monadなどの理解を深める 

