//: Playground - noun: a place where people can play

import UIKit
import XCPlayground
import C4
import GLKit

class WorkSpace: CanvasController {
    let radius = 100.0
    let duration = 0.3
    
    var circle: Shape!
    var canDraw = true
    
    override func setup() {
        canvas.backgroundColor = C4Purple
        createCircle()
        addAnimation()
    }
    
    func createCircle() {
        let bezier = UIBezierPath()
        var r = radius
        0.stride(through: 1080, by: 10).forEach { i in
            let radian = Double(GLKMathDegreesToRadians(Float(i)))
            let x = cos(radian) * r + canvas.center.x
            let y = sin(radian) * r + canvas.center.y
            
            let point = CGPoint(x: x, y: y)
            if i == 0 {
                bezier.moveToPoint(point)
            } else {
                bezier.addLineToPoint(point)
            }
            r -= 0.8
        }
        let path = Path(path: bezier.CGPath)
        let shape = Shape(path)
        shape.fillColor = clear
        shape.lineWidth = 2.0
        shape.strokeStart = 0.0
        shape.strokeEnd = 0.0
        shape.strokeColor = C4Blue
        canvas.add(shape)
        
        self.circle = shape
    }
    
    func addAnimation() {
        canvas.addTapGestureRecognizer { _, _, _ in
            let animation = ViewAnimation(duration: self.duration) {
                self.circle.strokeEnd = self.canDraw ? 1.0 : 0.0
                self.circle.strokeColor = self.canDraw ? C4Blue : C4Pink
            }
            animation.curve = .EaseIn
            animation.addCompletionObserver {
                self.canDraw = !self.canDraw
            }
            animation.animate()
        }
    }
}

let ws = WorkSpace()
XCPlaygroundPage.currentPage.liveView = ws.view

