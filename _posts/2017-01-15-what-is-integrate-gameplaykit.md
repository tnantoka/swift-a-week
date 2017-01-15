---
layout: post
title: "Integrate GameplayKitオプションは何なのか"
categories: example
---

Xcode 8から`Game`テンプレートでプロジェクト新規作成時に`Integrate GameplayKit`というオプションが選択できるようになりました。  
今まで気にはなりつつ使ってなかったのですが、このオプションの有無でプロジェクトがどう変わるのか確認してました。

Diffを見た感じGameplayKitっぽいコードは書かれていますが、実際には使われていないようにみえます。  
（`.sks`に特に変更がなく、`entities`や`graphs`が空のまま）

あくまで土台だけでExampleは含まないテンプレートということでしょうか？  
deltaTimeの計算が最初から入れてあるのは楽でいいですね。

## ソースコード

- <https://github.com/tnantoka/IntegrateGameplayKit>
