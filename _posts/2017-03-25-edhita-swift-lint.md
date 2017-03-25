---
layout: post
title: "EdhitaにSwiftLintを導入"
categories: example
---

Objective-CからSwiftに書き直して以降、あまり手を入れられていないEdhitaですが、
そろそろSwiftらしくしていきたいな、ということでまずはSwiftLintを導入しました。

{% highlight sh %}
# Podfile
pod 'SwiftLint'

$ pod install
$ open Edhita.xcworkspace/

# Build Phases -> New Run Script Phase
"${PODS_ROOT}/SwiftLint/swiftlint"
{% endhighlight %}

これでBuildすればXcode上で指摘してくれるようになります。
今回はautocorrectは使わずにせっせと手で直しました。

TODOは使いたかったので無効化しました。

{% highlight sh %}
# .swiftlint.yml 
disabled_rules:
  - todo
{% endhighlight %}

また、Hound CIのline_lengthが100になってたのでSwiftLintの現在のデフォルトである120になるように設定しました。

結果はこちらです。

<https://github.com/tnantoka/edhita/pull/19>
