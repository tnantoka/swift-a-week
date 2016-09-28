//
//  ViewController.swift
//  HelloSceneKit
//
//  Created by Tatsuya Tobioka on 9/27/16.
//  Copyright © 2016 tnantoka. All rights reserved.
//

import UIKit
import SceneKit
import GLKit

class ViewController: UIViewController {

    lazy var scnView: SCNView = {
        let scnView = SCNView(frame: CGRect.zero)
        scnView.showsStatistics = true
        scnView.backgroundColor = UIColor.black
        scnView.allowsCameraControl = true
        self.view.addSubview(scnView)
        
        scnView.translatesAutoresizingMaskIntoConstraints = false
        
        let views = ["scnView": scnView]
        
        let vertical = NSLayoutConstraint.constraints(
            withVisualFormat: "V:|-0-[scnView]-0-|",
            options: [],
            metrics: nil,
            views: views
        )
        let horizontal = NSLayoutConstraint.constraints(
            withVisualFormat: "H:|-0-[scnView]-0-|",
            options: [],
            metrics: nil,
            views: views
        )
        NSLayoutConstraint.activate(vertical + horizontal)
        
        return scnView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        let scene = SCNScene()
        scnView.scene = scene
        
        let cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        cameraNode.position = SCNVector3(x: 0, y: 0, z: 5.0)
        scene.rootNode.addChildNode(cameraNode)
        
        scnView.autoenablesDefaultLighting = true
        
        let box = SCNBox(width: 1.0, height: 1.0, length: 1.0, chamferRadius: 0.1)
        let boxNode = SCNNode(geometry: box)
        boxNode.rotation = SCNVector4(1.0, 1.0, 0.0, GLKMathDegreesToRadians(30.0))
        scene.rootNode.addChildNode(boxNode)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

