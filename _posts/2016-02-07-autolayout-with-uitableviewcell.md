---
layout: post
title:  "UITableViewCellでAutoLayout関連のエラーメッセージが表示される"
categories: tips
---

次出すアプリの開発にかかりっきりなので、今週も小ネタでお茶を濁します。

条件によって表示・非表示が変わるSubviewを持つUITableViewCellのサブクラスを作りました。
表示上は特に問題はなかったのですが、動的にCellを追加した時に、以下の様なエラーメッセージが表示されていました。

{% highlight sh %}
Unable to simultaneously satisfy constraints.
  Probably at least one of the constraints in the following list is one you don't want. 
  Try this: 
    (1) look at each constraint and try to figure out which you don't expect; 
    (2) find the code that added the unwanted constraint or constraints and fix it. 
(
    "<NSLayoutConstraint:0x7fa2f8d609f0 V:[UIButton:0x7fa2f8d50700'Button'(32)]>",
    "<NSLayoutConstraint:0x7fa2f8d3ca20 V:[UIView:0x7fa2f8d9a4d0(44)]>",
    "<NSLayoutConstraint:0x7fa2f8d12560 V:[UIImageView:0x7fa2f8d123b0(0)]>",
    "<NSLayoutConstraint:0x7fa2f8d3c720 V:|-(0)-[UIButton:0x7fa2f8d50700'Button']   (Names: '|':UITableViewCellContentView:0x7fa2f8d5bf80 )>",
    "<NSLayoutConstraint:0x7fa2f8d4e820 V:[UIButton:0x7fa2f8d50700'Button']-(0)-[UILabel:0x7fa2f8d194d0'Test']>",
    "<NSLayoutConstraint:0x7fa2f8d4e8c0 V:[UILabel:0x7fa2f8d194d0'Test']-(8)-[UIView:0x7fa2f8d9a4d0]>",
    "<NSLayoutConstraint:0x7fa2f8d4e960 V:[UIView:0x7fa2f8d9a4d0]-(0)-[UIImageView:0x7fa2f8d123b0]>",
    "<NSLayoutConstraint:0x7fa2f8d4ea50 V:[UIImageView:0x7fa2f8d123b0]-(8)-|   (Names: '|':UITableViewCellContentView:0x7fa2f8d5bf80 )>",
    "<NSLayoutConstraint:0x7fa2f8d57200 'UIView-Encapsulated-Layout-Height' V:[UITableViewCellContentView:0x7fa2f8d5bf80(59.5)]>"
)

Will attempt to recover by breaking constraint 
<NSLayoutConstraint:0x7fa2f8d3ca20 V:[UIView:0x7fa2f8d9a4d0(44)]>

Make a symbolic breakpoint at UIViewAlertForUnsatisfiableConstraints to catch this in the debugger.
The methods in the UIConstraintBasedLayoutDebugging category on UIView listed in <UIKit/UIView.h> may also be helpful.
{% endhighlight %}

なお、TableViewは[Bondのデモアプリ](https://github.com/SwiftBond/Bond-Demo-App)と同じ方法で表示しています。

AutoLayoutはまだあまり使いこなせておらず苦戦しましたが、44pxに固定していたSubviewのAutoLayoutのPriorityを1000から750に下げることで解消しました。  
参考：<http://cocoadays.blogspot.jp/2015/01/autolayout.html>

