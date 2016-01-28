---
layout: post
title:  "UIAppearanceを設定したら既存のTableViewが動かなくなった"
categories: tips
---

ちょっと体調を崩したので今週は小ネタです。

[Eureka](https://github.com/xmartlabs/Eureka)を使って設定画面を作りました。  
その後、他の部分の開発を進めている間、設定画面を見ることがありませんでした。

そして、久々に設定画面ボタンをタップしたら、何も表示されなくなっていました。（NavigationBarすら出ない状態）  
いろいろ調べた結果、`tableHeaderView`に追加した`UISearchBar`の上部に表示されるグレー背景を消すために入れた、以下の記述が原因[^1]のようでした。

{% highlight swift %}
UITableView.appearance().backgroundView = UIView()
{% endhighlight %}

`appearanceWhenContainedInInstancesOfClasses:`を使って特定のControllerだけに適用するようにしたら、無事表示されるようになりました。

UI Testsをちゃんと書こうと思いました…。

[^1]: Eurekaの中身までは確認していません。そして、悪いのはEurekaではなく僕です！

