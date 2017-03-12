---
layout: post
title: "Swift製の静的サイトジェネレーター「Spelt」を使ってみる"
categories: example
---

Swiftで書かれたStatic Site Generatorを見つけたので試してみました。  
[njdehoog/Spelt: Delightfully simple static site generator written in Swift](https://github.com/njdehoog/Spelt)

Macアプリ用に作られたようですが、CLIはオープンソースで公開されています。

### Spelt導入・プロジェクト作成

{% highlight sh %}
$ git clone --recursive https://github.com/njdehoog/Spelt.git
$ make bootstrap
$ make prefix_install

$ spelt new hello-spelt
$ cd hello-spelt/
{% endhighlight %}

### 設定・プレビュー

{% highlight sh %}
# _config.yml 
title: "Hello Spelt"
description: >
  Spelt Example

url: "http://hello-spelt.bornneet.com"
date_format: "MMM dd, yyyy"
paginate: 5

$ spelt preview 
# http://0.0.0.0:ポート番号
{% endhighlight %}

### GitHub Pagesで公開

{% highlight sh %}
# build.sh
#!/bin/sh
rm -rf docs
spelt build --destination docs
echo "hello-spelt.bornneet.com" > docs/CNAME
$ ./build.sh

# .gitignore 
_build

$ git init
$ git add .
$ git commit -m "first commit"
$ git remote add origin git@github.com:tnantoka/hello-spelt.git
$ git push origin master
{% endhighlight %}

こんな感じで公開できました。

<http://hello-spelt.bornneet.com/>

しばらく使ってみようと思います。
