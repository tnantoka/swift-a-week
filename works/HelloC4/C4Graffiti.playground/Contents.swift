//: Playground - noun: a place where people can play

import UIKit
import XCPlayground
import C4
import GLKit
import GameplayKit

class WorkSpace: CanvasController {
    let fileManager = NSFileManager.defaultManager()
    let docPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0]
    var rootPath: String {
        return "\(docPath)/"
    }
    
    override func viewDidLoad() {
        view.frame.size = CGSizeMake(1500.0, 500.0)
        super.viewDidLoad()
    }
    
    override func setup() {
        canvas.backgroundColor = C4Grey
        
        (0..<100).forEach { i in
            createLine()
        }
    }
    
    func createLine() {
        var x = Double(GKRandomDistribution(lowestValue: 0, highestValue: Int(canvas.width)).nextInt())
        var y = Double(GKRandomDistribution(lowestValue: 0, highestValue: Int(canvas.height)).nextInt())
        
        let count = GKRandomDistribution(lowestValue: 2,highestValue: 6).nextInt()
        
        let bezier = UIBezierPath()
        bezier.moveToPoint(CGPoint(x: x, y: y))

        (0..<count).forEach { i in
            let scale = GKRandomDistribution(lowestValue: 30, highestValue: 100).nextInt()
            let scale2 = scale * 2
            
            let x2 = x + Double(GKRandomDistribution(lowestValue: -scale, highestValue: scale).nextInt())
            let y2 = y + Double(GKRandomDistribution(lowestValue: -scale, highestValue: scale).nextInt())

            let x3 = x + Double(GKRandomDistribution(lowestValue: -scale2, highestValue: scale2).nextInt())
            let y3 = y + Double(GKRandomDistribution(lowestValue: -scale, highestValue: scale2).nextInt())

            bezier.addQuadCurveToPoint(CGPoint(x: x3, y: y3), controlPoint: CGPoint(x: x2, y: y2))

//            x = x3
//            y = y3
        }
        
        let colors = [C4Blue, C4Pink, C4Purple]
        
        let path = Path(path: bezier.CGPath)
        let shape = Shape(path)
        shape.fillColor = clear
        shape.lineWidth = Double(GKRandomDistribution(lowestValue: 2, highestValue: 12).nextInt())
        shape.strokeColor = colors[GKRandomDistribution(lowestValue: 0, highestValue: 2).nextInt()]
        canvas.add(shape)
    }
    
    func save() {
        let image = create()
        
        let filename = "image.png"
        let data = UIImagePNGRepresentation(image)!
        
        let path = "\(rootPath)\(filename)"
        
        fileManager.createFileAtPath(
            path,
            contents: data,
            attributes: nil
        )
        
        print("$ \(path)")
    }
    
    private func create() -> UIImage {
        let size = CGSize(width: canvas.width, height: canvas.height)
        
        let opaque = true
        let scale: CGFloat = 1.0
        UIGraphicsBeginImageContextWithOptions(size, opaque, scale)
        
        let context = UIGraphicsGetCurrentContext()!
        view.layer.renderInContext(context)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        return image
    }
}

let ws = WorkSpace()
//XCPlaygroundPage.currentPage.liveView = ws.view

let _ = ws.view
ws.create()
ws.save()




