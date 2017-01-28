//: Playground - noun: a place where people can play

import UIKit
import GameplayKit

let source = GKPerlinNoiseSource()

let noise = GKNoise(source)
noise.move(by: vector_double3(x: 0.0, y: 0.0, z: 2.0))
let map = GKNoiseMap(noise)

//(0..<map.sampleCount.x).forEach { x in
//    (0..<map.sampleCount.y).forEach { y in
//        print(map.value(at: vector_int2(x: x, y: y)))
//    }
//}

class WobblyCircleView: UIView {
    let padding: CGFloat = 30.0
    
    override func draw(_ rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()!
        
        UIColor.white.setFill()
        UIColor.black.setStroke()
        context.fill(rect)
        
        let ellipseRect = CGRect(x: padding, y: padding, width: rect.width - padding * 2.0, height: rect.height - padding * 2.0)
        drawEllipse(context: context, rect: ellipseRect)
    }
    
    func withRotation(step: Float, callback: (Float, CGFloat) -> Void) {
        var degree: Float = 0.0
        repeat {
            let radian = CGFloat(GLKMathDegreesToRadians(degree))
            callback(degree, radian)
            degree += step
        } while degree <= 360.0
    }
    
    func drawEllipse(context: CGContext, rect: CGRect) {
        var i = 0
        
        withRotation(step: 5.0) { degree, radian in
            var point = self.ellipsePoint(rect: rect, radian: radian)
            
            if degree > 0.0 && degree < 360.0 {
                // Perlin Noise
                let mappedI = Int32(mapped(value: i, start1: 0, stop1: 71, start2: 0, stop2: 99))
                point.x += 40.0 * CGFloat(map.value(at: vector_int2(x: mappedI, y: 0)))
                point.y += 40.0 * CGFloat(map.value(at: vector_int2(x: 0, y: mappedI)))
                
                // Random
//                point.x += CGFloat(GKRandomDistribution(lowestValue: -4, highestValue: 4).nextInt())
//                point.y += CGFloat(GKRandomDistribution(lowestValue: -4, highestValue: 4).nextInt())
                
                i += 1
            }
            
            if degree == 0.0 {
                context.move(to: point)
            } else {
                context.addLine(to: point)
            }
        }
        //context.closePath()
        context.strokePath()
    }
    
    func ellipsePoint(rect: CGRect, radian: CGFloat) -> CGPoint {
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let rx = rect.width /  2.0
        let ry = rect.height / 2.0
        
        let x = center.x + cos(radian) * rx
        let y = center.y + sin(radian) * ry
        
        return CGPoint(x: x, y: y)
    }
    
    func mapped(value: Int, start1: Int, stop1: Int, start2: Int, stop2: Int) -> Int  {
        return start2 + (value - start1) * (stop2 - start2) / (stop1 - start1)
    }
}

let view = WobblyCircleView(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
