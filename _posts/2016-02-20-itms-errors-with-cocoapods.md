---
layout: post
title:  "CocoaPodsを使ってるプロジェクトがiTunes Connectにアップロードできない"
categories: tips
---

ようやく完成したアプリを、いざiTunes Connectにアップロードしようとしたら、ITMS-XXXXXと言われた…よくある話です。

今回遭遇したのは以下の4つでした。

## ITMS-90164

これはいろんなプロジェクトでたまになりますが、原因不明です。
もう一度Archiveしたら解消します。

## ITMS-90060

`:head`を指定しているPodがあると発生します。
以下のIssueにあるコードを`post_install`に追加することで消えました。

<https://github.com/CocoaPods/CocoaPods/issues/4421#issuecomment-158074101>

## ITMS-90205, ITMS-90206

Extension内に不要なディレクトリが作られてしまうことが原因のようです。

Extensionのターゲットの`Run Script Phase`に下記コメントのシェルを追加して、
`Embedded Content Contains Swift Code`をNOにしたらエラーは出なくなりました。

<https://github.com/CocoaPods/CocoaPods/issues/4203#issuecomment-147550871>

まだ審査は通ってないですが、TestFlightでは動いているのでこれで大丈夫だと思います。

