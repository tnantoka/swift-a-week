---
layout: post
title:  "Functional Swiftを読む その2"
categories: book
---

[先週](/book/2016/01/10/read-functional-swift-1.html)の宿題を解消すべく、引き続き[Functional Swift](http://px.a8.net/svt/ejp?a8mat=1NWF4Y+EFRJQY+249K+BWGDT&a8ejpredirect=http%3A%2F%2Fwww.amazon.co.jp%2Fdp%2FB00UY3K04O%2F%3Ftag%3Da8-affi-205968-22)を読みました。


## 宿題1: 10章を参考に何かを作る

この章では、グラフをNSViewやPDFに出力するコマンドを、関数型っぽい書き方で実装します。
2章のThinking Functionallyとはまた違った書き方でした。

それぞれ以下のようなメリットがあります。

### 2章: shallow embedding

- 実装が簡単
- 実行のオーバーヘッドが少ない
- 新しい関数を追加する拡張が容易

### 10章: deep embedding

- データ構造を他の用途に流用しやすい

やはりdeep embeddingの方が難しく、 勉強のために2章のコードを書き換えようとしましたが、あまり面白くなかったので、
10章のコードをUIView上で動くように書き換えてみました。

<https://github.com/tnantoka/swift-a-week/blob/gh-pages/works/DiagramsWithUIKit.playground/Contents.swift>

オリジナルのソースコードは[こちら](https://github.com/objcio/functional-swift/blob/master/diagrams.swift)です。  

`NS`を`UI`に変えたり、PDFなどの不要なfunctionを消したりしてますが、ほぼそのままで動きました。
（これがdeep embeddingのメリットですね）

一番面倒だったのは`NSView`と`UIView`でy軸が逆なところでした。

{% highlight swift %}
CGContextTranslateCTM(context, 0.0, rect.size.height)
CGContextScaleCTM(context, 1.0, -1.0)
{% endhighlight %}

だと文字が反転しちゃったので`.Below`, `alignTop`, `alignBottom`を変更して対応しました。

## 宿題2: 12章のParserを写経

1回目読んだ時に途中でついていけなくなったので、コードを書き写しながら読み直しました。

`ArraySlice`と`AnySequence`がパッと読めなかったので、以下のようなコードを書いて試しました。  

`ArraySlice`は配列の一部を抜き出したものということでシンプルです。  
`AnySequence`は`AnyGenerator`と組み合わせて`Sequecne`をクロージャで作れる、といったところでしょうか。正直なところ、`anyGenerator`だけ使った場合と比較しての利点がわかってないです。

{% highlight swift %}
// ArraySlice

let array = ["a", "b", "c", "d", "e"]
let slice = array[1..<3]
slice[1] // b
slice.dynamicType // ArraySlice<String>.Type
//slice[0] // error
Array(slice)[0] // b


// AnySequence

let sequence = AnySequence{ Void -> AnyGenerator<Int> in
    var i = 0
    return anyGenerator { Void -> Int? in
        i += 1
        return i > 5 ? nil : i
    }
}

for s in sequence {
    print(s)
}

let mapped = sequence.map { $0 }
mapped // [1, 2, 3, 4, 5]

{% endhighlight %}

写経したコードについては、オリジナルとほぼ差分なしのため、公開はやめておきます。  
オリジナルのソースコードは[こちら](https://github.com/objcio/functional-swift/blob/master/parsing.swift)にあります。

## 宿題3: Functor、Applicative、Monadなどの理解を深める 

JavaScriptを始めた時、`Closure`の概念にとても苦労した覚えがあります。  
今思えば、細かいことを気にせず慣れるまで触ってればわかっただろうに…という感じなのですが、いろいろ自分なりに説明しようとしたのは後々役に立ったので、今の理解で関数型言語の概念を説明してみます。

[すごいHaskellたのしく学ぼう!](http://px.a8.net/svt/ejp?a8mat=1NWF4Y+EFRJQY+249K+BWGDT&a8ejpredirect=http%3A%2F%2Fwww.amazon.co.jp%2Fdp%2F4274068854%2F%3Ftag%3Da8-affi-255514-22)では以下のような記述があります。

用語 | ページ | 引用
--- | --- | ---
Functor | p. 228 | 関数で写せるもの
Applicative Functor | p. 40 | 「ファンクターの中の関数」で「別のファンクターの中の値」を写す
Monad | p. 282 | 普通の値aを取って文脈付きの値を返す関数に、文脈付きの値m aを渡したい

本書ではこう述べられています。

用語 | ページ | 引用
--- | --- | ---
Functor | p. 187 | Type constructors — such as optionals or arrays — that support a map operation are sometimes referred to as functors. 
Applicative Functor | p. 189 | Any type constructor for which we can define appropriate pure and `<*>` operations is called an applicative functor. 
Monad | p. 192 | a type constructor F is a monad if it defines the following two functions: `func pure<A>(value: A) -> F<A>`, `func flatMap<A, B>(x: F<A>)(f: A -> F<B>) -> F<B>`

そして、今の僕の頭の中を、Swiftを使って説明するとこうなります。  
（誤った記述がある可能性が高いため、ご注意ください）

## Functor 

その型が持つ値にたいして、文脈を保ったまま関数を適用できるものです。

{% highlight swift %}
func f(num: Int) -> String {
    return String(num)
}

[1, 2, 3].map(f) // ["1", "2", "3"], Array<Int> -> Array<String>
(1 as Int?).map(f) // "1", Optional<Int> -> Optional<String>
{% endhighlight %}

この例では、それぞれArray・Optionalのままで、その中身の値を関数`f`で変換しています。

## Applicative Functor

Functorの強化版です。（AppilcativeはFunctorでもあります）  
文脈付きの関数を適用できるFunctorです。

{% highlight swift %}
func pure<A>(value: A) -> A? {
    return value
}

infix operator <*> { associativity left precedence 150 }
func <*><A, B>(transform: (A -> B)?, value: A?) -> B? {
    guard let transform = transform, value = value else { return nil }
    return transform(value)
}

let flag: Bool? = true
pure(!) <*> flag // false, Optional<Int>

let num1: Int? = 1
let num2: Int? = 2

func curry<A, B, C>(f: (A, B) -> C) -> A -> (B -> C) {
    return { x in
        { y in
            f(x, y)
        }
    }
}

pure(curry(+)) <*> num1 <*> num2 // 3, Optional<Int>
{% endhighlight %}

`Bool?`の例では、Optionalに対して、Optionalに入れた`!`関数を適用しています。  
`Int?`の例では、curry化した`+`にnum1を渡して得た関数に、さらにnum2を渡して加算しています。

## Monad

Applicative Functorの強化版です。（MonadはApplicativeでもあります）  
普通の値を受け取る関数に、文脈付きの値を渡して文脈付きの結果を得ることができます。

{% highlight swift %}
let str: String? = "1"

func f(str: String) -> Int? {
    return Int(str)
}

str.map(f) // 1, Optional<Optional<Int>>
str.flatMap(f) // 1, Optionam<Int>
{% endhighlight %}

この`flatMap`がモナドが持つ機能で、普通の`String`を受け取る`f`に`String?`を渡し、`Int?`を得ています。  
（`map`だと`Int??`になってしまう）

と、現状ではこのようにまだまだ理解できておらず、どういう時に役立つかもまだ説明できません。  
12章のParserのtoInteger2のところに、Applicativeが使われているのはわかるのですが、自分がコードを書くときにうまく使える自信はありません。

本書を読むのをメインにするのはひとまず今週で終わりにしようと思いますが、引き続き関数型プログラミングの学習は続けていこうと思います。

Functional Swift、今後も読み返すことになるであろう、良い本でした。

<table cellpadding="0" cellspacing="0" border="0" style=" border-style: none; width:170px;"><tr style="border-style:none;"><td style="vertical-align:top; border-style:none; padding:10px;"><a href="http://px.a8.net/svt/ejp?a8mat=1NWF4Y+EFRJQY+249K+BWGDT&a8ejpredirect=http%3A%2F%2Fwww.amazon.co.jp%2Fdp%2FB00UY3K04O%2F%3Ftag%3Da8-affi-255514-22" target="_blank"><img border="0" alt="" src="http://ecx.images-amazon.com/images/I/31rBSsCp5GL._SS160_.jpg" /></a></td></tr><tr style="border-style:none;"></tr></table>
<img border="0" width="1" height="1" src="http://www12.a8.net/0.gif?a8mat=1NWF4Y+EFRJQY+249K+BWGDT" alt="">


# 参考

- [Haskell - 箱で考えるFunctor、ApplicativeそしてMonad - Qiita](http://qiita.com/suin/items/0255f0637921dcdfe83b)
- [Applicative functor](http://www.slideshare.net/UsrNameu1/applicative-functor)
- [ファンクタ, アプリカティブ, モナド](https://gist.github.com/kohyama/5856037)

