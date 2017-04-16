---
layout: post
title:  "RxSwift本 1週目"
categories: book
---

[RxSwift \| Ray Wenderlich](https://store.raywenderlich.com/products/rxswift)

第4章まで読みました。以下メモです。

僕のRxSwift力は昔hello worldをやったっきりでほぼ0です。
この本には一度軽く流して呼んで、1つアプリを作成が見返していこうと思っています。

## 2章

Streamとは呼ばずにSequenceと呼ぶのがクールらしい。

{% highlight swift %}
Observable.of(one, two, three) // Observable<Int>
Observable.of([one, two, three]) // Observable<[Int]>
Observable.from([one, two, three]) // Observable<Int>
{% endhighlight %}

ややこしい。

- `observable.subscribe(_:)`と`if let element = event.element`のショートカットが`observable.subscribe(onNext:)`
- `empty`はすぐCompleted
- `never`は何も起きない

## 3章

- `PublishSubject`は`subject.onNext("2")`とかした時に流れる
- `subscriptionOne.dispose()`したやつは止まる
- `BehaviorSubjects`はsubscribeした時の値が即座に流れて来る
- `ReplaySubjects`はバッファーサイズ分流れて来る
- `Variables`は`value`を変えれば`onNext`しなくても流れてくる

### 4章

- コラージュアプリを作るサンプル
- ImagesがVariables
- imagesの変更を受けてUpdateUIで諸々更新
- PhotosControlelrがdelegate受けて、それをObservableに
- Custom Observableで画像のsave
- Resouse countingを有効化してメモリーリークを見る
- なんでもObservableでいけるのよさそう

