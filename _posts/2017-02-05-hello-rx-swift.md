---
layout: post
title: "Hello, RxSwift"
categories: example
---

前々から触ってみなきゃなと思っていたRxSwiftをようやく触りはじめました。

今回作ったのは、TextViewに入力した文字数を数えて表示＆50文字を超えていたらカウントを赤くする、という単純なものです。

{% highlight swift %}
let count = textView.rx.text.orEmpty
    .distinctUntilChanged()
    .map { $0.characters.count }
    .shareReplay(1)
count.map { $0.description }
    .bindTo(countLabel.rx.text)
    .addDisposableTo(disposeBag)
count.map { $0 > 50 }
    .map { $0 ? .red : .black }
    .subscribe(onNext: { self.countLabel.textColor = $0 })
    .addDisposableTo(disposeBag)
{% endhighlight %}

BondのメジャーアップデートとSwift 3化を同時に行うのがとても大変だったのもあり、
アプリ全体の書き方に関わるライブラリを導入するのに抵抗感があるのですが、
こういう局所的な用途で使っていくのはありかなぁ、と思っています。

## ソースコード

<https://github.com/tnantoka/swift-a-week/blob/gh-pages/works/HelloRxSwift>
