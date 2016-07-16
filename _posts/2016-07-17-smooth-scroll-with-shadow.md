---
layout: post
title:  "影付きのViewをスムーズにスクロールする"
categories: tips
---

今更な話題ですが…。  
Collection ViewなどのCellに、何も考えずに影をつけてスクロールが重くなってしまいました。

以下の2行を追加することで解消しました。

{% highlight swift %}
cell.layer.shouldRasterize = true
cell.layer.rasterizationScale = UIScreen.mainScreen().scale
{% endhighlight %}

実機で試してみたところ、`shadowPath`を設定しなくても十分効果がありそうです。
（シミュレータ上ではまだカクつきますが）

### 参考

[影付きビューの表示を高速化する - Qiita](http://qiita.com/yuch_i/items/4b3aea76772c103c215b)
