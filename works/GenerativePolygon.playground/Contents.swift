//: Playground - noun: a place where people can play

import UIKit
import XCPlayground
import GLKit
import GameplayKit

let mdColors = [
    UIColor(red: 244.0 / 255.0, green: 67.0 / 255.0, blue: 54.0 / 255.0, alpha: 1.0),
    UIColor(red: 233.0 / 255.0, green: 30.0 / 255.0, blue: 99.0 / 255.0, alpha: 1.0),
    UIColor(red: 156.0 / 255.0, green: 39.0 / 255.0, blue: 176.0 / 255.0, alpha: 1.0),
    UIColor(red: 103.0 / 255.0, green: 58.0 / 255.0, blue: 183.0 / 255.0, alpha: 1.0),
    UIColor(red: 63.0 / 255.0, green: 81.0 / 255.0, blue: 181.0 / 255.0, alpha: 1.0),
    UIColor(red: 33.0 / 255.0, green: 150.0 / 255.0, blue: 243.0 / 255.0, alpha: 1.0),
    UIColor(red: 3.0 / 255.0, green: 169.0 / 255.0, blue: 244.0 / 255.0, alpha: 1.0),
    UIColor(red: 0.0 / 255.0, green: 188.0 / 255.0, blue: 212.0 / 255.0, alpha: 1.0),
    UIColor(red: 0.0 / 255.0, green: 150.0 / 255.0, blue: 136.0 / 255.0, alpha: 1.0),
    UIColor(red: 76.0 / 255.0, green: 175.0 / 255.0, blue: 80.0 / 255.0, alpha: 1.0),
    UIColor(red: 139.0 / 255.0, green: 195.0 / 255.0, blue: 74.0 / 255.0, alpha: 1.0),
    UIColor(red: 205.0 / 255.0, green: 220.0 / 255.0, blue: 57.0 / 255.0, alpha: 1.0),
    UIColor(red: 255.0 / 255.0, green: 235.0 / 255.0, blue: 59.0 / 255.0, alpha: 1.0),
    UIColor(red: 255.0 / 255.0, green: 193.0 / 255.0, blue: 7.0 / 255.0, alpha: 1.0),
    UIColor(red: 255.0 / 255.0, green: 152.0 / 255.0, blue: 0.0 / 255.0, alpha: 1.0),
    UIColor(red: 255.0 / 255.0, green: 87.0 / 255.0, blue: 34.0 / 255.0, alpha: 1.0),
    UIColor(red: 121.0 / 255.0, green: 85.0 / 255.0, blue: 72.0 / 255.0, alpha: 1.0),
    UIColor(red: 158.0 / 255.0, green: 158.0 / 255.0, blue: 158.0 / 255.0, alpha: 1.0),
    UIColor(red: 96.0 / 255.0, green: 125.0 / 255.0, blue: 139.0 / 255.0, alpha: 1.0),
]

class View: UIView {
    var circuits = 3
    
    override func drawRect(rect: CGRect) {
        UIColor.whiteColor().setFill()
        UIRectFill(rect)
        
        let context = UIGraphicsGetCurrentContext()
        
        (0..<polygons()).forEach { _ in
            drawPolygon(context, rect: rect)
        }
    }
    
    func drawPolygon(context: CGContext?, rect: CGRect) {
        let firstPoint = self.point(0, radius: radius(), rect: rect)
        var lastPoint = firstPoint
        
        let step = 360 / number()
        1.stride(through: 360, by: step).forEach { i in
            let point = self.point(CGFloat(i), radius: radius(), rect: rect)
            addLine(context, from: lastPoint, to: point)
            
            lastPoint = point
        }
        
        addLine(context, from: lastPoint, to: firstPoint)
    }
    

    func addLine(context: CGContext?, from: CGPoint, to: CGPoint) {
        color().setStroke()
        CGContextMoveToPoint(context, from.x, from.y)
        CGContextAddLineToPoint(context, to.x, to.y)
        CGContextStrokePath(context)
    }
    
    func point(degree: CGFloat, radius: CGFloat, rect: CGRect) -> CGPoint {
        let radian = CGFloat(GLKMathDegreesToRadians(Float(degree)))
        let x = CGRectGetMidX(rect) + cos(radian) * radius
        let y = CGRectGetMidY(rect) + sin(radian) * radius
        return CGPoint(x: x, y: y)
    }
    
    func color() -> UIColor {
        let index = Int(arc4random_uniform(UInt32(mdColors.count)))
        return mdColors[index]
    }
    
    func radius() -> CGFloat {
        let maxRadius = 150
        let step = maxRadius / circuits

        let radiuses = step.stride(through: maxRadius, by: step).map { $0 }
        
        let index = Int(arc4random_uniform(UInt32(radiuses.count)))
        
        return CGFloat(radiuses[index])
    }
    
    func polygons() -> Int {
        return 30
        return GKRandomDistribution(lowestValue: 3, highestValue: 3 + circuits).nextInt()
    }
    
    func number() -> Int {
        return 12
        return GKRandomDistribution(lowestValue: 50, highestValue: 150).nextInt()
    }
}


XCPlaygroundPage.currentPage.liveView = View(frame: CGRect(x: 0, y: 0, width: 320, height: 320))