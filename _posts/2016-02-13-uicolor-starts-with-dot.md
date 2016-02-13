---
layout: post
title:  "ドットで始められるのはenumだけじゃない"
categories: tips
---

小ネタでお送りするのは今週で最後の予定です。

Objective-CからSwiftに移行してきた際に、初見でわからなかった記法の一つがドット始まりです。

## Before

{% highlight swift %}
if UIDevice.currentDevice().userInterfaceIdiom == UIUserInterfaceIdiom.Phone
{% endhighlight %}

## After

{% highlight swift %}
if UIDevice.currentDevice().userInterfaceIdiom == .Phone
{% endhighlight %}

こう書けるものですね。

最初の刷り込みでenumの時しか使う頭がなかったんですが、これ、Classでも使えるんですよね。  
つまり、以下のように書けるわけです

{% highlight swift %}
view.backgroundColor = .redColor()
{% endhighlight %}

これに気づいた時、今までタイプした'UIColor.'を返してくれーってなりました…。  
文法の勉強は正確に。

