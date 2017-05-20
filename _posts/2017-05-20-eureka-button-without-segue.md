---
layout: post
title:  "EurekaのButtonRowでSegueを使わずに画面遷移"
categories: tips
---

Exampleにはsegueを使った遷移しかないんですよね。（CustomRowの例としてはありますが）
Storyboardを使わない派は生きづらい世の中です。

{% highlight swift %}
ButtonRow { row in
    row.title = NSLocalizedString("Acknowledgements", comment: "")
    row.presentationMode = .show(
        controllerProvider: ControllerProvider.callback { AcknowListViewController() },
        onDismiss: nil
    )
}
{% endhighlight %}

これでいけます。
