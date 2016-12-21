---
layout: page
title: 関数型プログラミングの参考資料
permalink: /functional.html
---

僕がSwiftでの関数型プログラミングを学習する過程で、参考にさせてもらった資料です。  
以下のように難易度をつけています。

難易度 | 説明
--- | ---
★☆☆ | 関数型プログラミング未経験でも役に立つ。
★★☆ | すごいHaskell本などに目を通した後の方が良い。
★★★ | 僕のレベルを超えているため評価できない。

僕の理解が深まればより正確な分類ができるようになると思います。

リンク | 難易度 | 言語 | 種類 | その他
--- | --- | --- | --- | ---
[すごいHaskellたのしく学ぼう!](http://px.a8.net/svt/ejp?a8mat=1NWF4Y+EFRJQY+249K+BWGDT&a8ejpredirect=http%3A%2F%2Fwww.amazon.co.jp%2Fdp%2F4274068854%2F%3Ftag%3Da8-affi-255514-22) | ★☆☆ | 日本語 | 書籍 | 
[Functional Swift](http://px.a8.net/svt/ejp?a8mat=1NWF4Y+EFRJQY+249K+BWGDT&a8ejpredirect=http%3A%2F%2Fwww.amazon.co.jp%2Fdp%2F3000480056%2F%3Ftag%3Da8-affi-255514-22) | ★★☆ | 英語 | 書籍 |
[Functional Programming in Swiftを読むために、すごいH本を読み終えた感想](http://egg-is-world.com/2015/09/09/sugoi-haskell-book/) | ★☆☆ | 日本語 | 書籍 | すごいHaskell → Functional Swiftの順で読むというアドバイスが役立った。
[関数型プログラミングの基礎 JavaScriptを使って学ぶ](https://px.a8.net/svt/ejp?a8mat=1NWF4Y+EFRJQY+249K+BWGDT&a8ejpredirect=https%3A%2F%2Fwww.amazon.co.jp%2Fdp%2F4865940596%2F%3Ftag%3Da8-affi-255514-22) | ★☆☆ | 日本語 | 書籍 | JavaScriptを題材にわかりやすく書かれていて、GitHub Pages上に動くサンプルも用意されていて理解の助けになった。

<script>
window.addEventListener('load', function() {
  $('table:first th').attr('data-sortable', false);
  $('table').attr('data-sortable', true);
  Sortable.init();
});
</script>
