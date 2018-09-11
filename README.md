# Swift a Week

http://swiftaweek.bornneet.com/

```
$ jekyll serve -w --future
```

```
$ git checkout gh-pages
$ git pull origin gh-pages
$ WEEK=2
$ git checkout -b week-$WEEK
$ git commit --allow-empty -m "Week $WEEK"
$ git push origin week-$WEEK
```
