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
        
        var frame = self.frame
        frame.origin.y = 20.0
        frame.size.height -= frame.origin.y
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
        
//        let physicsBody = SKPhysicsBody(circleOfRadius: radius) // Doesn't work with scale action
        let physicsBody = SKPhysicsBody(rectangleOfSize: playerNode.frame.size)
        physicsBody.categoryBitMask = Category.player
        physicsBody.restitution = 0.0
        playerNode.physicsBody = physicsBody
        
        addChild(playerNode)
    }
    
    func jump() {
        guard !jumping else { return }
        jumping = true
 
        let vector = CGVector(dx: 0, dy: 150)
        playerNode.physicsBody?.applyImpulse(vector)
    }
    
    func squash() {
        jump()
        
        let actions = [
            SKAction.scaleXTo(0.5, y: 1.5, duration: 0.2),
            SKAction.waitForDuration(0.4),
            SKAction.scaleXTo(1.0, y: 1.0, duration: 0.2),
            SKAction.waitForDuration(0.2),
            SKAction.scaleXTo(1.5, y: 0.5, duration: 0.2),
            SKAction.waitForDuration(0.1),
            SKAction.scaleXTo(1.0, y: 1.0, duration: 0.1),
            ]
        
        let sequence = SKAction.sequence(actions)
        playerNode.runAction(sequence)
    }
    
    // MARK: - SKPhysicsContactDelegate
    
    func didBeginContact(contact: SKPhysicsContact) {
        jumping = false
    }
}
