//
//  ViewController.swift
//  LTNSC4
//
//  Created by Tatsuya Tobioka on 2/25/17.
//  Copyright © 2017 tnantoka. All rights reserved.
//

import UIKit
import GameplayKit
import C4

class ViewController: CanvasController {
    var center: Point { return canvas.center }
    var radius: Double { return canvas.width * 0.3 }
    
    override func setup() {
        let source = GKPerlinNoiseSource()
        
        let noise = GKNoise(source)
        let noiseMap = GKNoiseMap(noise)
        
        let points = stride(from: 0.0, to: 360.0, by: 5.0).map { deg -> Point in
            let radian = degToRad(deg)
            var x = center.x + radius * cos(radian)
            var y = center.x + radius * sin(radian)
            
            let mappedDeg = Int32(map(deg, min: 0.0, max: 71.0, toMin: 0.0, toMax: 99.0))
            
            x += 20.0 * Double(noiseMap.value(at: vector_int2(x: mappedDeg, y: 0)))
            y += 20.0 * Double(noiseMap.value(at: vector_int2(x: 0, y: mappedDeg)))

            return Point(x, y)
        }
        let polygon = Polygon(points)
        polygon.center = center
        polygon.close()
        canvas.add(polygon)
    }
}

