---
layout: post
title:  "URLからユニークなファイル名を生成したい"
categories: example
---

Web上にあるPDFファイルを表示するときに、明示的に更新しない限りはキャッシュしておいたローカルのファイルを見る、という機能を実装しようとしていました。
キャッシュ用のディレクトリにファイルを保存しているのですが、元のファイル名をそのまま使ってしまうと、同じファイル名だった場合に衝突してしまいます…。

こういう時、MD5などを使えば簡単に一意な名前を使えます。Swiftでハッシュ関数を使うには、

1. CommonCryptを使う
1. PureSwiftのライブラリを使う
1. 独自実装する

のような方法があります。
今回実装したかったのはライブラリの中だったので、依存を増やす1・2の方式はあまり採用したくありませんでした。
ということで3を試みていたのですが、時間の都合上断念…。

最終的に、ホスト名と最初のpathとファイル名を繋ぎ合わせた超簡易実装になりました。

{% highlight swift %}
func cacheName(url: NSURL) -> String {
    let separator = "_"
    let host = (url.host ?? "").stringByReplacingOccurrencesOfString(".", withString: separator)
    
    let first = (url.pathComponents?.dropFirst().first ?? "")
    let last = (url.lastPathComponent ?? "")
    
    return [host, first, last].joinWithSeparator(separator)
}

let url = NSURL(string: "http://test.example.com/path/to/file.txt")!
cacheName(url) // "test_example_com_path_file.txt" 
{% endhighlight %}

重複しすぎて使い物にならないようだったらまた考えます…。

