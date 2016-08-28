//
//  ViewController.swift
//  IllusionOfLife
//
//  Created by Tatsuya Tobioka on 8/21/16.
//  Copyright © 2016 tnantoka. All rights reserved.
//

import UIKit
import SpriteKit

class ViewController: UIViewController {

    @IBOutlet weak var skView: SKView!
    
    var scene: Scene!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        skView.showsFPS = true
//        skView.showsPhysics = true
        
        scene = Scene(size: skView.bounds.size)
        skView.presentScene(scene)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func jumpDidTap(sender: AnyObject) {
        scene.jump()
    }
    
    @IBAction func squashDidTap(sender: AnyObject) {
        scene.squash()
    }
}

