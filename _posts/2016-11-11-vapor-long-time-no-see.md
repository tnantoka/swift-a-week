---
layout: post
title: "久しぶりにVaporに触る"
categories: example
---

Swift 3が正式リリースされてから、触っていませんでした。
久々に見てみると、ドキュメントや周辺ツールがかなり充実していました。

## インストール

{% highlight sh %}
$ curl -sL check.vapor.sh | bash
✅  Compatible

# これをやらないとInstalling...から進みませんでした
$ brew uninstall vapor
Uninstalling /usr/local/Cellar/vapor/0.4.1... (4 files, 17.7K)

$ curl -sL toolbox.vapor.sh | bash
✅  Compatible
Downloading...
Compiling...
Installing...
Vapor Toolbox v1.0.3 Installed
Use vapor --help and vapor <command> --help to learn more.

$ vapor --help
Usage: vapor <new|build|run|fetch|clean|test|xcode|version|self|heroku|docker>
Join our Slack if you have questions, need help,
or want to contribute: http://vapor.team
{% endhighlight %}

## プロジェクト作成　

{% highlight sh %}
$ vapor new LTNSVapor
$ cd LTNSVapor/
$ vapor xcode -y
{% endhighlight %}

`App` Schemeを選択して実行すると、<http://localhost:8080/>でアクセスできるようになっています。

## Postsを使えるように

この状態で、<http://localhost:8080/posts> にアクセスすると以下のようなエラーになります。

> Uncaught Error: EntityError.noDatabase. Use middleware to catch this error and provide a better response. Otherwise, a 500 error page will be returned in the production environment.

[vapor/AuthTests.swift at master · vapor/vapor](https://github.com/vapor/vapor/blob/master/Tests/VaporTests/AuthTests.swift) を参考に、Memoryにデータを保存するようにしました。

{% highlight swift %}
let database = Database(MemoryDriver())
drop.database = database
drop.preparations.append(Post.self)
{% endhighlight %}

また、`Post.swift`に以下の記述があり、これを消さないとshowのURLにアクセスするたびに勝手にモデルが作成されてしまうので、コメントアウトします。

{% highlight swift %}
extension Post {
    /**
        This will automatically fetch from database, using example here to load
        automatically for example. Remove on real models.
    */
    public convenience init?(from string: String) throws {
        self.init(content: string)
    }
}
{% endhighlight %}

これでPostsのリソースが動くようになりました。
確認のため、`welcome.leaf`に以下のようなFormを書きました。

{% highlight js %}
    <div id="posts"></div>

    <script src="https://cdnjs.cloudflare.com/ajax/libs/react/15.3.2/react.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/react/15.3.2/react-dom.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/babel-core/5.8.38/browser.min.js"></script>
    <script type="text/babel">
        class PostList extends React.Component {
            constructor(props) {
                super(props)
                this.state = {
                    posts: [],
                    content: '',
                }
            }
            componentDidMount() {
                this.load()
            }
            load() {
                fetch('/posts')
                .then(response => response.json())
                .then(json => {
                    this.setState({ posts: json })
                })
            }
            handleSubmit(event) {
                event.preventDefault()
                const headers = new Headers()
                headers.append('Content-Type', 'application/json')
                fetch('/posts', {
                    method: 'POST',
                    headers: headers,
                    body: JSON.stringify({ content: this.state.content }),
                })
                .then(() => this.load())
                this.setState({ content: '' })
            }
            handleChange(event) {
                this.setState({ content: event.target.value })
            }
            handleDelete(id) {
                fetch('/posts/' + id, {
                    method: 'DELETE',
                })
                .then(() => this.load())
            }
            render() {
                return (
                    <ul>
                        {this.state.posts.map(post =>
                            <li>
                                <a href={ `/posts/${post.id}` }>{ post.content }</a>
                                &nbsp;
                                <a onClick={ () => this.handleDelete(post.id) } style={{ cursor: 'pointer' }}>&times;</a>
                            </li>
                        )}
                        <li>
                            <form onSubmit={ this.handleSubmit.bind(this) }>
                                <input type="text" value={ this.state.content } onChange={ this.handleChange.bind(this) } />
                                <input type="submit" value="Add" />
                            </form>
                        </li>
                    </ul>
                )
            }
        }

        ReactDOM.render(<PostList />, document.getElementById('posts'))
    </script>
{% endhighlight %}

![](/images/posts/vapor-long-time-no-see/form.png)

以前よりもっと手軽に使えるようになった感じでした。
Herokuへのデプロイも簡単にできるようなので、何か作ったら今度はHerokuにあげてみようと思います。

## 参考

- [Vapor Documentation](https://vapor.github.io/documentation/)
- [Heroku に Vapor をデプロイする \| digitrick Notes](http://dev.digitrick.us/notes/VaporOnHeroku)

## ソースコード

<https://github.com/tnantoka/swift-a-week/tree/gh-pages/works/LTNSVapor>
