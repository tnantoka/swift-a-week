//: Playground - noun: a place where people can play

import UIKit
import XCPlayground

class View: UIView {
    let padding: CGFloat = 5.0
    let cornerRadius: CGFloat = 10.0

    override func drawRect(rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()!
        
        UIColor.whiteColor().setFill()
        CGContextFillRect(context, rect)
        
        var bubbleRect = rect
        bubbleRect.origin.x += padding
        bubbleRect.origin.y += padding
        bubbleRect.size.width -= padding * 2.0
        bubbleRect.size.height -= padding * 2.0
        
        bubble(context, bubbleRect)
    }
    
    func bubble(context: CGContext, _ rect: CGRect) {
        
        let arrowWidth: CGFloat = 10.0
        let arrowHeight: CGFloat = 20.0
        let arrowTopCurveHeight: CGFloat = 4.0
        
        let leftX = CGRectGetMinX(rect) + arrowWidth
        let rightX = CGRectGetMaxX(rect)
        let topY = CGRectGetMinY(rect)
        let bottomY = CGRectGetMaxY(rect)
        
        CGContextBeginPath(context)
        
        CGContextMoveToPoint(
            context,
            leftX,
            topY + cornerRadius
        )
        
        arc(
            context,
            leftX + cornerRadius,
            topY + cornerRadius,
            180.0,
            270.0
        )
        
        arc(
            context,
            rightX - cornerRadius,
            topY + cornerRadius,
            270.0,
            360.0
        )
        
        arc(
            context,
            rightX - cornerRadius,
            bottomY - cornerRadius,
            0.0,
            90.0
        )
        
        arc(
            context,
            leftX + cornerRadius,
            bottomY - cornerRadius,
            90.0,
            125.0
        )
        
        CGContextAddQuadCurveToPoint(
            context,
            leftX,
            bottomY,
            leftX - arrowWidth,
            bottomY
        )
        CGContextAddQuadCurveToPoint(
            context,
            leftX,
            bottomY - arrowTopCurveHeight,
            leftX,
            bottomY - arrowHeight
        )
        
        CGContextClosePath(context)
        
        UIColor.blackColor().setStroke()
        CGContextStrokePath(context)
    }
    
    func arc(context: CGContext, _ x: CGFloat, _ y: CGFloat, _ startAngle: CGFloat, _ endAngle: CGFloat) {
        CGContextAddArc(
            context,
            x,
            y,
            cornerRadius,
            radian(startAngle),
            radian(endAngle),
            0
        )
    }
    
    func radian(degree: CGFloat) -> CGFloat {
        return degree * CGFloat(M_PI) / 180.0
    }
}


XCPlaygroundPage.currentPage.liveView = View(frame: CGRect(x: 0, y: 0, width: 300, height: 100))