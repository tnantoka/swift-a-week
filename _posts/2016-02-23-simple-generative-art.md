---
layout: post
title:  "PlaygroundでとてもシンプルなGenerative Art"
categories: tips
---

一時期Generative Artというものに興味を持って、以下の本を読みました。

<table cellpadding="0" cellspacing="0" border="0" style=" border-style: none; width:170px;"><tr style="border-style:none;"><td style="vertical-align:top; border-style:none; padding:10px 10px 0pt;"><a href="http://px.a8.net/svt/ejp?a8mat=1NWF4Y+EFRJQY+249K+BWGDT&a8ejpredirect=http%3A%2F%2Fwww.amazon.co.jp%2Fdp%2F4861009634%2F%3Ftag%3Da8-affi-255514-22" target="_blank"><img border="0" alt="" src="http://ecx.images-amazon.com/images/I/41Eq81vSVPL._SS160_.jpg" /></a></td></tr><tr style="border-style:none;"><td style="font-size:12px; vertical-align:middle; border-style:none; padding:10px;"><p style="padding:0; margin:0;"><a href="http://px.a8.net/svt/ejp?a8mat=1NWF4Y+EFRJQY+249K+BWGDT&a8ejpredirect=http%3A%2F%2Fwww.amazon.co.jp%2Fdp%2F4861009634%2F%3Ftag%3Da8-affi-255514-22" target="_blank">[普及版]ジェネラティブ・アート―Processingによる実践ガイド</a></p></td></tr></table>

その後ちゃんと勉強を続けなかったのでほとんど覚えていませんが、印象に残ってるアプローチは、

- 円などの図形を既存の機能使って描く
- それを三角関数などを使って、自分で描く形に変える
- そこにノイズを加える

というものでした。
そんなシンプルな方法でそれっぽいものが書けるのか…と。

今回は、それを単純化したものをPlayground上でやってみました。

## 1. 楕円を描く

まずは普通に円を描きます。

{% highlight swift %}
class GenerativeView1: UIView {
    let width: CGFloat = 40.0
    let height: CGFloat = 140.0
    
    var bgColor: CGColor {
        return UIColor.whiteColor().CGColor
    }
    
    override func drawRect(rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()

        CGContextSetFillColorWithColor(context, bgColor)
        CGContextFillRect(context, rect)
        
        CGContextSetLineCap(context, .Round)
        draw(rect, context: context)
    }
    
    func draw(rect: CGRect, context: CGContextRef?) {
        let center = CGPointMake(CGRectGetMidX(rect), CGRectGetMidY(rect))
        let ellipseRect = CGRectMake(center.x - width / 2.0, center.y - width / 2.0, width, height)
        
        drawEllipse(context, rect: ellipseRect)
    }
    
    func drawEllipse(context: CGContextRef?, rect: CGRect) {
        CGContextStrokeEllipseInRect(context, rect)
    }
}
{% endhighlight %}

![](/images/posts/simple-generative-art/ellipse.png)

## 2. 花びらのように並べる

次にそれを円状に並べて花のようにしてみます。

{% highlight swift %}
class GenerativeView2: GenerativeView1 {
    override func draw(rect: CGRect, context: CGContextRef?) {
        drawWithRotation(rect, context: context) { [width, height, drawEllipse] in
            let ellipseRect = CGRectMake(-width / 2.0, -width / 2.0, width, height)
            drawEllipse(context, rect: ellipseRect)
        }
    }
    
    func drawWithRotation(rect: CGRect, context: CGContextRef?, callback: Void -> Void) {
        let center = CGPointMake(CGRectGetMidX(rect), CGRectGetMidY(rect))
        CGContextTranslateCTM(context, center.x, center.y)
        
        withRotation(20.0) { _, radian in
            CGContextSaveGState(context)
            CGContextRotateCTM(context, radian)
            callback()
            CGContextRestoreGState(context)
        }
    }
    
    func withRotation(step: Float, callback: (Float, CGFloat) -> Void) {
        var degree: Float = 0.0
        repeat {
            let radian = CGFloat(GLKMathDegreesToRadians(degree))
            callback(degree, radian)
            degree += step
        } while degree < 360.0
    }
}
{% endhighlight %}

![](/images/posts/simple-generative-art/flower.png)

## 3. 自分で円を描くように書き換える

円を自分で描くように変更します。`2. `と同じ形が描ければOKです。

{% highlight swift %}
class GenerativeView3: GenerativeView2 {
    override func drawEllipse(context: CGContextRef?, rect: CGRect) {
        withRotation(10.0) { degree, radian in
            let point = self.ellipsePoint(rect, radian: radian)
            
            if degree == 0.0 {
                CGContextMoveToPoint(context, point.x, point.y)
            } else {
                CGContextAddLineToPoint(context, point.x, point.y)
            }
        }
        CGContextClosePath(context)
        CGContextStrokePath(context)
    }
    
    func ellipsePoint(rect: CGRect, radian: CGFloat) -> CGPoint {
        let center = CGPointMake(CGRectGetMidX(rect), CGRectGetMidY(rect))
        let rx = rect.width /  2.0
        let ry = rect.height / 2.0

        let x = center.x + cos(radian) * rx
        let y = center.y + sin(radian) * ry
        
        return CGPointMake(x, y)
    }
}
{% endhighlight %}

![](/images/posts/simple-generative-art/manually.png)

## 4. 線にノイズを加える

ランダムに変化を付けながら線を描きます。

{% highlight swift %}
class GenerativeView4: GenerativeView3 {
    override func ellipsePoint(rect: CGRect, radian: CGFloat) -> CGPoint {
        let center = CGPointMake(CGRectGetMidX(rect), CGRectGetMidY(rect))
        let rx = rect.width /  2.0
        let ry = rect.height / 2.0
        
        
        let x = center.x + cos(radian) * rx + random(Int(width) / 2)
        let y = center.y + sin(radian) * ry + random(Int(height) / 2)
        
        return CGPointMake(x, y)
    }
    
    func random(range: Int) -> CGFloat {
        if GKRandomDistribution.d6().nextInt() == 1 {
            return CGFloat(GKRandomDistribution(lowestValue: -range, highestValue: range).nextInt())
        } else {
            return 0
        }
    }
}
{% endhighlight %}

![](/images/posts/simple-generative-art/noise.png)

## 5. 線の太さや色も変える

最後に見た目をちょっと整えます。

{% highlight swift %}
class GenerativeView5: GenerativeView4 {
    override var bgColor: CGColor {
        return UIColor.blackColor().CGColor
    }

    override func drawEllipse(context: CGContextRef?, rect: CGRect) {
        let width = 2.0 + random(1)
        CGContextSetLineWidth(context, width)
        CGContextSetStrokeColorWithColor(context, randomColor().CGColor)
        CGContextSetShadowWithColor(context, CGSizeZero, width * 2.0, UIColor.whiteColor().CGColor)
        super.drawEllipse(context, rect: rect)
    }
    
    func randomColor() -> UIColor {
        switch GKRandomDistribution.d6().nextInt() {
        case 1, 2:
            return UIColor(red: randomColorItem(), green: 1.0, blue: 1.0, alpha: 1.0)
        case 3, 4:
            return UIColor(red: 1.0, green: randomColorItem(), blue: 1.0, alpha: 1.0)
        case 5, 6:
            return UIColor(red: 1.0, green: 1.0, blue: randomColorItem(), alpha: 1.0)
        default:
            return .whiteColor()
        }
    }
    
    func randomColorItem() -> CGFloat {
        return CGFloat(GKRandomDistribution(lowestValue: 100, highestValue: 255).nextInt()) / 255.0
    }
}
{% endhighlight %}

![](/images/posts/simple-generative-art/styles.png)

上であげた本にはもっと素敵なサンプルがたくさん載っています。
紙を買うとフルカラーのPDFももらえます。

## ソースコード

<https://github.com/tnantoka/swift-a-week/tree/gh-pages/works/GenerativeArt.playground>


