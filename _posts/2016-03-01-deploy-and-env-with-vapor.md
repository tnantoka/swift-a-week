---
layout: post
title:  "Hello Vapor 2: デプロイと環境変数"
categories: example
---

ローカルで動かすだけだとつまらないので、デプロイして公開してみます。

まずは、[DigitalOcean](https://m.do.co/c/b40cbbff5f74)で`Ubuntu 14.04.4 x64`のDropletを作成します。
この状態でrootユーザーとして鍵認証できるようになっているので、そのまま進めることにします。

`~/.ssh/config`に以下のように設定して、`ssh vapor`でアクセスできるようにします。

{% highlight sh %}
Host vapor
  HostName 45.55.12.166 
  User root
{% endhighlight %}

次にAnsibleでNginxやSwiftをインストールします。

{% highlight sh %}
$ sudo easy_install pip
$ sudo pip install ansible
$ ansible --version
ansible 2.0.1.0

$ ansible-playbook playbook.yml -i hosts
{% endhighlight %}

playbookはこちらにあります。
<https://github.com/tnantoka/swift-a-week/tree/gh-pages/works/AnsibleForVapor>

最後に[HelloVapor](/2016/02/28/hello-vapor.html)をデプロイします。
ここもAnsibleや他のツールでやってもよいんですが、ひとまず手動で行います。

$ ./clean.sh; scp -r ../HelloVapor vapor:/var/www/
$ ssh vaypor
$ cd /var/www
$ cd HelloVapor
$ ./build.sh
$ start HelloVapor

これで以下のURLでHelloVaporにアクセスできるようになりました。

<http://hello.vapor.swiftaweek.com/>

次に環境変数を表示してみます。
いろいろやり方はあると思いますが、ひとまず起動スクリプトで設定します。

`env.yml`はこのように書いて、`.gitignore`しています。
{% highlight sh %}
env:
  - { name: "TEST", value: "test" }
{% endhighlight %}

<http://env.vapor.swiftaweek.com/>

Hello testの`test`の部分が環境変数から取った値です。

思ったよりハマりどころが少なかったです。引き続きいろいろやってみようと思います。

## ソースコード

- <https://github.com/tnantoka/swift-a-week/tree/gh-pages/works/AnsibleForVapor>
- <https://github.com/tnantoka/swift-a-week/tree/gh-pages/works/VaporWithEnv>

