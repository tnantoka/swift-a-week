---
layout: post
title:  "Hello C4 その3: LineとPointの衝突判定"
categories: example
---

引き続き[C4](https://github.com/C4Framework/C4iOS)を触っています。

ProcessingのサンプルをC4で書いてみていて、ある点が線に接触しているかを判別する必要がありました。

元のProcessingではピクセル情報で判別していたので、UIViewを画像に変換して同じようにしてみましたが遅すぎました…。

C4の`Line` (`Shape`)には`hitTest`というメソッドがあり、厳密に衝突しているかを判別すればいい場合、これが使えそうです。
ただ、今回は一定の誤差を許容したかったので以下の様なメソッドをextensionで追加しました。

{% highlight swift %}
extension Line {
    func contains(point: Point) -> Bool {
        let x0 = points[0].x
        let y0 = points[0].y
        let x1 = points[1].x
        let y1 = points[1].y
        let x2 = point.x
        let y2 = point.y
        let l1 = sqrt(pow((x1 - x0), 2) + pow((y1 - y0), 2))
        let l2 = sqrt(pow((x2 - x0), 2) + pow((y2 - y0), 2))
        
        let v = (x1 - x0) * (x2 - x0) + (y1 - y0) * (y2 - y0)
        let l = l1 * l2
        
        let margin = 1.0
        return  v > l - margin && v < l + margin && l1 >= l2
    }
}
{% endhighlight %}

<http://marupeke296.com/COL_2D_No2_PointToLine.html>
を参考にさせていただきました。

