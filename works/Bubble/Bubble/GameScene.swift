//
//  GameScene.swift
//  Bubble
//
//  Created by Tatsuya Tobioka on 10/3/16.
//  Copyright © 2016 tnantoka. All rights reserved.
//

import SpriteKit
import GameplayKit


struct BitMask {
    static let noiseField: UInt32 = 1 << 0
}

class GameScene: SKScene {
    
    override func didMove(to view: SKView) {
        
        // Get label node from scene and store it for use later
        let noiseField = SKFieldNode.noiseField(withSmoothness: 0.3, animationSpeed: 0.0)
        noiseField.strength = 0.1
        noiseField.categoryBitMask = BitMask.noiseField
        addChild(noiseField)
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        
        let radius: CGFloat = 40.0
        let circleNode = SKShapeNode(circleOfRadius: radius)
        circleNode.position = location
        circleNode.physicsBody = SKPhysicsBody(circleOfRadius: radius)
        circleNode.physicsBody?.affectedByGravity = false
        circleNode.physicsBody?.fieldBitMask = BitMask.noiseField
        addChild(circleNode)
    }
}
