---
layout: post
title:  "Eurekaをカスタムオペレータ無しで使う"
categories: tips
---

Swiftは独自の演算子を定義できますが、僕はあれがわりと苦手です。
他の言語にあるものとかを移植するのは歓迎なのですが。

<https://github.com/xmartlabs/Eureka#how-to-create-a-form>

{% highlight swift %}
form +++ Section("Section1")
    <<< TextRow(){ row in
        row.title = "Text Row"
        row.placeholder = "Enter text here"
    }
    <<< PhoneRow(){
        $0.title = "Phone Row"
        $0.placeholder = "And numbers here"
    }
+++ Section("Section2")
    <<< DateRow(){
        $0.title = "Date Row"
        $0.value = Date(timeIntervalSinceReferenceDate: 0)
    }
{% endhighlight %}

これは本当に人間に読みやすくなっているのでしょうか…。

{% highlight swift %}
form.append(contentsOf: [
    Section("Section1") { section in
        section.append(contentsOf: [
            TextRow { row in
                row.title = "Text Row"
                row.placeholder = "Enter text here"
            },
            PhoneRow {
                $0.title = "Phone Row"
                $0.placeholder = "And numbers here"
            }
        ])
    },
    Section("Section2") { section in
        section.append(contentsOf: [
            DateRow {
                $0.title = "Date Row"
                $0.value = Date(timeIntervalSinceReferenceDate: 0)
            }
        ])
    }
])
{% endhighlight %}

というわけで、僕はいつもこのような書き方をしています。
これならEurekaを初めて見る人でも大丈夫です。

