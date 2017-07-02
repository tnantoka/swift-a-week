---
layout: post
title:  "EurekaのPushRowでセクションヘッダーではなくタイトルを使う"
categories: tips
---

{% highlight swift %}
.onPresent { _, toController in
    toController.title = NSLocalizedString("Title", comment: "")
    _ = toController.view
    toController.form.allSections.first?.header = nil
}
{% endhighlight %}

でいけました。

### 参考

<https://github.com/xmartlabs/Eureka/issues/715>
