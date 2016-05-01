//: Playground - noun: a place where people can play

import UIKit
import XCPlayground
import C4

class GlowView: UIView {
    var shadow: Shadow?
    
    override func drawRect(rect: CGRect) {
        drawShadow(rect)
    }
    
    func drawShadow(rect: CGRect) {
        guard let shadow = shadow else { return }
        
        let context = UIGraphicsGetCurrentContext()
        CGContextSaveGState(context)

        CGContextTranslateCTM(context, rect.size.width / 2, rect.size.height / 2)
        CGContextScaleCTM(context, 0.9, 0.9)
        CGContextBeginTransparencyLayer(context, nil)
        
        CGContextSetShadowWithColor(context, CGSize(shadow.offset), CGFloat(shadow.radius), shadow.color!.CGColor)
        
        CGContextSetBlendMode(context, .SourceOut)
        
        CGContextSetFillColorWithColor(context, shadow.color!.CGColor)
        
        CGContextAddPath(context, shadow.path!.CGPath)
        
        CGContextFillPath(context)
        
        CGContextEndTransparencyLayer(context)
        CGContextRestoreGState(context)
    }
}

class GlowView2: GlowView {
    var innerGlowSize: CGFloat = 0.0
    
    override func drawRect(rect: CGRect) {
        super.drawRect(rect)
        drawShape(rect)
    }
    
    func drawShape(rect: CGRect) {
        guard let shadow = shadow else { return }
        
        if innerGlowSize > 0 {
            UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
            let ctx = UIGraphicsGetCurrentContext()
            CGContextTranslateCTM(ctx, rect.size.width / 2, rect.size.height / 2)
            CGContextScaleCTM(ctx, 0.9, 0.9)

//            CGContextSetLineWidth(ctx, 8.0)
            CGContextSetStrokeColorWithColor(ctx, UIColor.whiteColor().CGColor)

            CGContextAddPath(ctx, shadow.path!.CGPath)
            CGContextStrokePath(ctx)
            
            let originImage = UIGraphicsGetImageFromCurrentImageContext()

            UIGraphicsEndImageContext()

            originImage.drawAtPoint(CGPointZero)
            UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
            let ctx2 = UIGraphicsGetCurrentContext()

            CGContextSaveGState(ctx2)
            CGContextSetFillColorWithColor(ctx2, UIColor.blackColor().CGColor)
            CGContextFillRect(ctx2, rect)
            CGContextTranslateCTM(ctx2, 0.0, rect.size.height)
            CGContextScaleCTM(ctx2, 1.0, -1.0)
            CGContextClipToMask(ctx2, rect, originImage.CGImage)
            CGContextClearRect(ctx2, rect)
            CGContextRestoreGState(ctx2)
            
            let inverted = UIGraphicsGetImageFromCurrentImageContext()
            CGContextClearRect(ctx2, rect)
            
            CGContextSaveGState(ctx2)
            CGContextSetFillColorWithColor(ctx2, shadow.color!.CGColor)
            CGContextSetShadowWithColor(ctx2, CGSizeZero, innerGlowSize, shadow.color!.CGColor)
            inverted.drawAtPoint(CGPointZero)
            CGContextTranslateCTM(ctx2, 0.0, rect.size.height)
            CGContextScaleCTM(ctx2, 1.0, -1.0)
            CGContextClipToMask(ctx2, rect, inverted.CGImage)
            CGContextClearRect(ctx2, rect)
            CGContextRestoreGState(ctx2)
            
            let innerShadow = UIGraphicsGetImageFromCurrentImageContext()
            
            UIGraphicsEndImageContext();
            
            innerShadow.drawAtPoint(rect.origin)
        }
    }
}


class WorkSpace: CanvasController {
    override func setup() {
        canvas.backgroundColor = Color(UIColor.blackColor())

//        shadow()
//        glow1()
        glow2()

    }
    
    func shadow() {
        let polygon = createPolygon(90)
        let shadow = createShadow(polygon.path!)
        polygon.shadow = shadow
        canvas.add(polygon)
    }
    
    func glow1() {
        let polygon = createPolygon(100)
        let shadow = createShadow(polygon.path!)
        
        let glowView = GlowView(frame: CGRect(polygon.frame))
        glowView.shadow = shadow
        view.addSubview(glowView)
    }
    
    func glow2() {
        let polygon = createPolygon(100)
        let shadow = createShadow(polygon.path!)
        
        let glowView = GlowView2(frame: CGRect(polygon.frame))
        glowView.shadow = shadow
        glowView.innerGlowSize = 4.0
        glowView.backgroundColor = UIColor.clearColor()
        view.addSubview(glowView)
        
//        let anim = ViewAnimation(duration: 1.0) {
//            View(view: shadowView).transform = Transform.makeRotation(M_PI)
//        }
//        anim.repeats = true
//        anim.animate()
    }
    
    func createPolygon(radius: Double) -> Polygon {
        let polygon = RegularPolygon(
            center: canvas.center,
            radius: 90,
            sides: 8,
            phase: 0
        )
        polygon.fillColor = nil
        polygon.strokeColor = Color(UIColor.whiteColor())
        polygon.lineWidth = 1.0
        
        return polygon
    }
    
    func createShadow(path: Path) -> Shadow {
        var shadow = Shadow()
        shadow.color = Color(UIColor(red: 0, green: 1, blue: 1, alpha: 1))
        shadow.radius = 20
        shadow.opacity = 1.0
        shadow.offset = Size(0, 0)
        shadow.path = path
        
        return shadow
    }
}

let ws = WorkSpace()
XCPlaygroundPage.currentPage.liveView = ws.view
//ws.view



