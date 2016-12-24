---
layout: post
title: "Hello Kitura: Kitura-StarterをBluemixにデプロイ"
categories: example
---

ムームードメインの無料キャンペーンで取得した後、長らく放置している<http://serversideswift.net>で何かしらのコンテンツを公開しようと考えています。
どうせならサーバ自体もSwiftでやりたいな、ということで、無料枠での運用が可能なBluemixを試してみます。

今まで[Vapor](https://github.com/vapor/vapor)しか触ってきませんでしたが、いい機会なので[Kitura](https://github.com/IBM-Swift/Kitura)を触って見ようと思います。

## クレジットカード情報の登録

アカウントはだいぶ前に作っていて、無料トライアルは終わってしまっていたので、本登録をしました。
[VANDLE CARD](https://vandle.jp/)を使いましたが、問題なく登録できました。

## スペースの作成

`米国南部`を選択するとスペースが無いと言われたので`dev`を作成しました。
（昔は自動で作られていたようです。以前使ったと思われる`シドニー`地域にはスペースがありました。）

## Kitura-Starter

KituraをBluemixにデプロイする最短距離は[Kitura-Starter](https://github.com/IBM-Bluemix/Kitura-Starter)を使うことのようだったので、[この手順](https://github.com/IBM-Bluemix/Kitura-Starter#clone-build-and-run-locally)に従って作業しました。

{% highlight sh %}
$ git clone https://github.com/IBM-Bluemix/Kitura-Starter.git serversideswift.net
$ cd serversideswift.net/

$ swift --version
Apple Swift version 3.0.2 (swiftlang-800.0.63 clang-800.0.42.1)
Target: x86_64-apple-macosx10.9

$ swift build
$ ./.build/debug/Kitura-Starter

$ open http://localhost:8090/
{% endhighlight %}

これでローカルでは動きました。

`Sources/Kitura-Starter/Controller.swift`を見てみると、`public`以下の`index.html`をそのまま返しているようです。

{% highlight swift %}
router.all("/", middleware: StaticFileServer())
{% endhighlight %}

## デプロイ

[コマンドラインツール](https://www.ng.bluemix.net/docs/starters/install_cli.html)を使います。

<https://github.com/cloudfoundry/cli/releases>から`Mac OS X 64 bit`をダウンロードして導入します。

{% highlight sh %}
$ cf -v
cf version 6.23.0+c7866be18-2016-12-22

$ cf api https://api.ng.bluemix.net
Setting api endpoint to https://api.ng.bluemix.net...
OK

API endpoint:   https://api.ng.bluemix.net
API version:    2.54.0
Not logged in. Use 'cf login' to log in.

$ cf login -u メールアドレス -o 組織名 -s スペース名
API endpoint: https://api.ng.bluemix.net

Password>
Authenticating...
OK

Targeted org 組織名

Targeted space スペース名



API endpoint:   https://api.ng.bluemix.net (API version: 2.54.0)
User:           ユーザー名
Org:            組織名
Space:          スペース名

$ cf buildpacks
Getting buildpacks...

buildpack                               position   enabled   locked   filename
liberty-for-java                        1          true      false    buildpack_liberty-for-java_v3.6-20161209-1351.zip
sdk-for-nodejs                          2          true      false    buildpack_sdk-for-nodejs_v3.9-20161128-1327.zip
dotnet-core                             3          true      false    buildpack_dotnet-core_v1.0.6-20161205-0912.zip
swift_buildpack                         4          true      false    buildpack_swift_v2.0.2-20161118-1326.zip
noop-buildpack                          5          true      false    noop-buildpack-20140311-1519.zip
java_buildpack                          6          true      false    java-buildpack-v3.6.zip
ruby_buildpack                          7          true      false    ruby_buildpack-cached-v1.6.16.zip
nodejs_buildpack                        8          true      false    nodejs_buildpack-cached-v1.5.11.zip
go_buildpack                            9          true      false    go_buildpack-cached-v1.7.5.zip
python_buildpack                        10         true      false    python_buildpack-cached-v1.5.5.zip
xpages_buildpack                        11         true      false    xpages_buildpack_v1.2.1-20160913-1038.zip
php_buildpack                           12         true      false    php_buildpack-cached-v4.3.10.zip
staticfile_buildpack                    13         true      false    staticfile_buildpack-cached-v1.3.6.zip
binary_buildpack                        14         true      false    binary_buildpack-cached-v1.0.1.zip
liberty-for-java_v3_4_1-20161030-2241   15         true      false    buildpack_liberty-for-java_v3.4.1-20161030-2241.zip
swift_buildpack_v2_0_1-20161103-0928    16         true      false    buildpack_swift_v2.0.1-20161103-0928.zip
sdk-for-nodejs_v3_8-20161006-1211       17         true      false    buildpack_sdk-for-nodejs_v3.8-20161006-1211.zip
liberty-for-java_v3_5-20161114-1152     18         true      false    buildpack_liberty-for-java_v3.5-20161114-1152.zip
dotnet-core_v1_0_1-20161005-1225        19         true      false    buildpack_dotnet-core_v1.0.1-20161005-1225.zip
xpages_buildpack_v1_2_1-20160913-103    20         true      false    xpages_buildpack_v1.2.1-20160913-1038.zip

# SwiftがあればOK

$ cf push
{% endhighlight %}

なお、`manifest.yml`に以下の変更を加えています。メモリは512MB以内なら無料枠でおさまるはずなのでそのままにしました。
{% highlight diff %}
 applications:
-- name: Kitura-Starter
+- name: serversideswift-net
   memory: 256M
   instances: 1
-  random-route: true
   disk_quota: 1024M
   command: Kitura-Starter
   buildpack: swift_buildpack
{% endhighlight %}

<https://serversideswift-net.mybluemix.net/>でローカルと同じ画面が見れれば成功です。


## 独自ドメインの設定

UIは変わっていますが、[こちら](http://dotnsf.blog.jp/archives/1018861460.html)の記事が参考になりました。

アプリ一覧からアプリを選択して、`アプリの表示`の横にある三角にマウスオーバーします。
`ドメインの管理`から、ドメインを追加して、`経路の編集`からアプリに追加する感じです。

※ 上部のアカウント名をクリックして最下部の「組織の管理」から編集に行ってもドメイン管理に辿りつけます。

今回は`serversideswift.net`ドメインを追加して（保存を忘れないように…）、`www`を経路として追加しました。
追加した直後はなぜかHTTPSに飛ばされてしまったんですが、少しまったらHTTPのままアクセスできるようになりました。

これでServerside Swiftなサイトを無料運用できそうです。

<http://www.serversideswift.net>

## ソースコード

- <https://github.com/tnantoka/serversideswift.net>
