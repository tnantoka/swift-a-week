---
layout: post
title: "Hello, ReSwift"
categories: example
---

諸事情でReduxを使うことになりそうなんですが、JSをそこまで書いていないのでイメージが湧かなくて困っています。
それならばSwiftで…ということでReSwiftに手を出してみました。

<https://github.com/ReSwift/ReSwift#about-reswift> を見ながらCounterのサンプルを書きました。
できたものは、当然ながら<https://github.com/ReSwift/CounterExample>とほぼ同じものになりました。

違いは、Reducerのテストを追加してあるところです。（Reduxのメリットの1つである、テストのしやすさを体験したかった）
ほんの少ししか書いていませんが、たしかに、Stateの変化だけ見ればいいので書きやすそうな気配です。

あと、Reducerの中で、`+= 1`してるのに違和感あるけど、触ってるのはコピーしたstructなので問題なし、という理解です。

うん、JSでやってるときより好きになれそうな気がしてきました。

## 参考

<http://blog.personal-factory.com/2015/12/31/you-can-layout-easly-via-stackview/>  
ボタンの配置にStackViewを使う際に参考にさせていただきました。 

## ソースコード

<https://github.com/tnantoka/swift-a-week/tree/gh-pages/works/HelloReSwift>
