---
layout: post
title:  "RxSwift本 2週目"
categories: book
---

[RxSwift \| Ray Wenderlich](https://store.raywenderlich.com/products/rxswift)

一通り目を通しました。メモはとても雑になってしまいましたが。

最後のTODOアプリを参考に何か作ろうと思ったのですが、構造が苦手な感じだったので、
データフローはReSwift(Redux)で、RxSwiftは便利なbindユーティリティとして使う感じでアプリを作ってみています。

## 5章
- `skip`は指定要素まで飛ばす
- `skipWhile`はtrueの間流れてこない
- `skipUntil`はtriggerがonNextされるまで
- `take`も同じような感じ
- `distinctUntilChanged`は値が変わった時だけ
- `ignoreElements`は何も流れて来なくなる
- `elementAt(_:)`は指定インデックスの要素
- `filter(_:)`は汎用

## 6章
- Observableを共有したい時は`share`を使う
- `ignoreElements`してcompletedかerrorのときだけ処理
- `filter`でユニークな画像だけにする
- `takeWhile`で個数制限
- カメラロールへのアクセス許可をいい感じにコントロール
- エラー表示のAlertをOvservableでハンドリング
- `SchedulerでAlert`を自動で閉じる
- `throttle`で無駄な処理をやめる

## 7章
- `toArray`で配列にできる
- `flatMap`でStrudentのscoreを監視
- `flatMapLatest`なら最後に設定されたStudentのscoreだけ監視

## 8章
- `flatMap`でrequestをobservableにしてresponseを待つ
- 1回しか実行したくないものは`shareReply(1)`で
- `flatMap`でnilなevent除外、neverも除外

## 9章
- `startWith`でprefix、`just`と`concat`を組み合わせても同じことできる
- `merge`したやつ全部がcpmpletedになったら終わる
- `combileLatest`、`zip`で要素をまとめる
- `withLatestFrom`、button押したらtextFieldの値を
- `switchLatest`で切り替え
- `scan`でreduceの過程を

## 10章
- `bindTo`でAPIの結果をvariableに
- openとclosedなAPIの結果を`concat`で
- categoryとeventのAPIを`combineLatest`で
- mergeを使ってopenとclosedを並列ダウンロード、`maxConcurrent`でサーバ負荷おさえる
- `scan`でインクリメンタルにUIを更新

## 11章
- 時間を扱うオペレータいろいろ
- `replay`して`connect`
- `replayAll`、メモリ注意

## 12章
- ApiController.sharedで天気を取得してobservableに
- searchFieldの`rx.text`が変化したときにも呼び出す
- searchを`flatMapLatest`で再利用可能にしてbindTo
- Driverとdrive使う、onErrorJustReturn
- controlEventでDidEndのときだけ処理する
- AcitivyIndicatorとかProgressBarにbindToできるやつ用意されてる

## 13章
- mergeでローディング状態を表示、startWithで初期表示を簡単に
- CCLocationManagerをいい感じに
- MapViewも
- 描画しすぎて遅くなるようなら何らかのdiff alogorithmで最適化しないとかも

## 14章
- `catchError`でエラーの時は前回のキャッシュ返したり
- `retry(3)`などでエラーの時にリトライ
-` retryWhen`で条件とか詳細にしたりできる

## 15章
- subscribeOn, observeOnでスレッド指定
- HTTPリクエストとかファイル出力とか副作用があるやつはcold observable(not shared)、subscribeされるまでなにもおきない

## 16章
- テスト
- RxTest(旧RxTests)、RxBlocking
- ViewModelのテスト

## 17章
- URLSessionをいい感じに、テストも
- RxDataSource、tableViewなどに
- RxAlamofire, RxBluetoothKit

## 18章
- Observableつくってitemsにbind
- modelSelectedでタップ
- ちょっとコード足せば複数のセルタイプも行ける
- setDelegateもできる
- RxDataSources使えばもっと便利に。差分やアニメーション

## 19章
- アクション
- login、passwordをcombileLatest
- loginButtonがそれをwithLatestFromして、loginActionにbind
- これでログインボタンを押したらログイン走る（終わるまで次は実行されない）
- loginActionをsubscribeして成功したら次のViewをpushするなど
- executeで手動発火もできる

## 20章
- tapGesture, anyGesture, when(.recognized)とかでお手軽に

## 21章
- RxRealm

## 22章
- RxAlamofire

## 23章
- ViewModel以下の階層はiOS, Macで共通
- navigationItemのclickとかもsubscribeで

## 24章
- TODOアプリ

## 参考 

### [ReSwiftのステートをRxSwiftを使って監視する - A Day In The Life](http://glassonion.hatenablog.com/entry/2017/04/20/195728)
ReSwiftのAppStateをObservableに

### [今日こそ理解するHot / Cold @社内RxSwift勉強会](https://www.slideshare.net/yukitakahashi3139241/hot-cold)
mapやfilterなどほとんどのオペレータはcold。subscribeされるまで動作しない。
coldは分岐できないので、sequenceが2つになる。
hotに変換すると同じsequenceを共有できる。

### [今日こそ理解するHot変換](https://www.slideshare.net/yukitakahashi3139241/hot-64131190)
publishやreplyはConnectableObservableを返す。
connect呼ぶまでは動作しない。
shareは内部でrefCount呼ぶ。subscribeされたらconnectする。subscribeされるまで動作しないhot。
shareReplay、shareしつつ指定個数だけbuffer。
shareReplayLatestWhileConnected、connect中しかreplayされない。completedになったらずっとcompleted。

### [RxSwiftと愉快な仲間たち / RxSwift with Units // Speaker Deck](https://speakerdeck.com/mihyaeru21/rxswift-with-units)
Driverは、エラー流れない・メインスレッドでobserve・shareReplayLatestWhileConnected。
Observableでもできるが、UIにbindする時によくやることをまとめてくれている。

今作ってるアプリだとDriver使いまくることになりそう。
