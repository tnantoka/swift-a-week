//: Playground - noun: a place where people can play

import UIKit
import XCPlayground


class View: UIView {
    let quality = 16
    var dots: [[UIColor]] = []
    
    var size: CGFloat {
        return bounds.size.width / CGFloat(quality)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.whiteColor()
        
        (0..<quality).forEach { i in
            let array = Array(count: quality, repeatedValue: UIColor.whiteColor())
            dots.append(array)
        }
    }
    
    override func drawRect(rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()!
        
        UIColor.whiteColor().setFill()
        CGContextFillRect(context, rect)
        
        for (i, line) in dots.enumerate() {
            let x = CGFloat(i) * size
            for (j, color) in line.enumerate() {
                let y = CGFloat(j) * size
                
                color.setFill()
                CGContextFillRect(context, CGRectMake(x, y, size, size))
            }
        }
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.locationInView(self)
        
        let i = Int(floor(location.x / size))
        let j = Int(floor(location.y / size))
        
        let color = dots[i][j] == UIColor.whiteColor() ? UIColor.blackColor() : UIColor.whiteColor()
        
        dots[i][j] = color
        
        setNeedsDisplay()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


XCPlaygroundPage.currentPage.liveView = View(frame: CGRect(x: 0, y: 0, width: 300, height: 300))