//: Playground - noun: a place where people can play

import UIKit
import GLKit
import GameplayKit

// Elipse

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
let view1 = GenerativeView1(frame: CGRectMake(0.0, 0.0, 300.0, 300.0))

// Elipse with Rotation

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
let view2 = GenerativeView2(frame: CGRectMake(0.0, 0.0, 300.0, 300.0))

// Elipse (Manually) with Rotation

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
let view3 = GenerativeView3(frame: CGRectMake(0.0, 0.0, 300.0, 300.0))

// Elipse (Manually with Noise) with Rotation

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
let view4 = GenerativeView4(frame: CGRectMake(0.0, 0.0, 300.0, 300.0))

// Elipse (Manually with Noise) with Rotation with Styles

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
let view5 = GenerativeView5(frame: CGRectMake(0.0, 0.0, 300.0, 300.0))

