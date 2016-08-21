//
//  Scene.swift
//  IllusionOfLife
//
//  Created by Tatsuya Tobioka on 8/21/16.
//  Copyright © 2016 tnantoka. All rights reserved.
//

import UIKit
import SpriteKit

class Scene: SKScene, SKPhysicsContactDelegate {
    struct Category {
        static let ground: UInt32 = 1 << 0
        static let player: UInt32 = 1 << 1
    }
    
    let radius: CGFloat = 30.0
    
    var contentCreated = false
    var jumping = false
    var playerNode: SKShapeNode!
    
    override func didMoveToView(view: SKView) {
        guard !contentCreated else { return }
        
        addShapeNode()
        
        let physicsBody = SKPhysicsBody(edgeLoopFromRect: frame)
        physicsBody.restitution = 0.0
        physicsBody.categoryBitMask = Category.ground
        physicsBody.contactTestBitMask = Category.player
        self.physicsBody = physicsBody
        
        physicsWorld.contactDelegate = self
        
        contentCreated = true
    }
    
    private func  addShapeNode() {
        playerNode = SKShapeNode(circleOfRadius: 30.0)
        
        playerNode.position = CGPoint(x: size.width / 2.0, y: size.height / 2.0)

        let physicsBody = SKPhysicsBody(circleOfRadius: radius)
        physicsBody.categoryBitMask = Category.player
        physicsBody.restitution = 0.0
        playerNode.physicsBody = physicsBody

        addChild(playerNode)
    }
    
    func jump() {
        guard !jumping else { return }
        jumping = true
 
        let vector = CGVector(dx: 0, dy: 100)
        playerNode.physicsBody?.applyImpulse(vector)
    }
    
    // MARK: - SKPhysicsContactDelegate
    
    func didBeginContact(contact: SKPhysicsContact) {
        jumping = false
    }
}
