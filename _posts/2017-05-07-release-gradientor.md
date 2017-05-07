---
layout: post
title:  "Gradientorをリリースしました"
categories: app
---

せっかくRxSwift本を読んだのでRxSwiftを使って1つアプリをリリースしました。

<https://www.gradientor.com/>

あまり非同期処理もないアプリで、無理やり使った感は否めませんが…。
最終的には、ReSwiftでデータを管理して、RxSwiftは便利なバインディングライブラリ、という感じになりました。

なお、途中でオープンソースにするのは手間がかかるので、今回は最初からソースコードを公開しています。

<https://github.com/tnantoka/gradientor>

このアプリは「ちゃんとテストを書く」というのをテーマにしています。
ひとまず簡単にかけるコントローラ部分の単体テストは書いたので、カバレッジ的には75%ぐらいになっています。
（テストのために`private`じゃなく`internal`にしちゃってるのが微妙に納得いきませんが、テストがないよりマシということで）

UIAlertControllerなど一手間かかる部分のテストも今後書いていきたいです。

あと、このアプリで作ったグラデーションを無料素材として配るつもりだったのですが、
僕のセンスの無さにより全然ギャラリーが充実していないため、そこもなんとかしたいと思います。

しばらくこのアプリのネタが続くかもしれません。

## 参考

- [【swift】グラデーションを描画する - tanihiro.log](http://tanihiro.hatenablog.com/entry/2016/05/25/201726)
- [iOS - iosアプリ　背景の放射状グラデーション(20632)\｜teratail](https://teratail.com/questions/20632)
- [Swift - UIImageをCoreGraphicsで回転させる - Qiita](http://qiita.com/mugmug-dev/items/c29de8ae2b838a633512)
- <https://github.com/CodeCatalyst/MaterialDesignColorPicker>
- [iOSアプリの国際化対応の勘所とTips集(Swift版) - Qiita](http://qiita.com/mono0926/items/c41c1ce18b90b765a8f2) スキーマの設定で日本語にしておいて、英語の時はホーム画面から。なるほど、楽でした。

