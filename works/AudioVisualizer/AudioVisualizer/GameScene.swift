//
//  GameScene.swift
//  AudioVisualizer
//
//  Created by Tatsuya Tobioka on 10/4/16.
//  Copyright © 2016 tnantoka. All rights reserved.
//

import SpriteKit
import GameplayKit
import AVFoundation

class GameScene: SKScene {
    
    var sparkNode: SKEmitterNode!
    var audioPlayer: AVAudioPlayer!
    
    var lastTime: TimeInterval = 0.0
    var elapsedTime: TimeInterval = 0.0

    let meterTable = MeterTable()!
    
    override func didMove(to view: SKView) {
        
        // Get label node from scene and store it for use later
        
        sparkNode = SKEmitterNode(fileNamed: "spark")!
        sparkNode.position = view.center
        addChild(sparkNode)

        sparkNode.particleBirthRate = 10.0
        sparkNode.particlePositionRange = CGVector(dx: 0, dy: 0)
        sparkNode.particleSpeed = 50.0
        sparkNode.particleSpeedRange = 100.0
        sparkNode.yAcceleration = 0.0
        
        let url = Bundle.main.url(forResource: "bgm_maoudamashii_fantasy04", withExtension: "mp3")!
        audioPlayer = try! AVAudioPlayer(contentsOf: url)
        audioPlayer.isMeteringEnabled = true
        audioPlayer.volume = 0.2
        audioPlayer.play()
    }

    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered

        if lastTime == 0.0 {
            lastTime = currentTime
        }
        elapsedTime += currentTime - lastTime
        if elapsedTime > 0.3 {
            elapsedTime = 0.0
            visualize()
        }
        lastTime = currentTime
    }
    
    private func visualize() {
        audioPlayer.updateMeters()
        let channels = audioPlayer.numberOfChannels
        // print("channels", channels)
        
        var power: Float = 0.0
        (0..<channels).forEach { i in
            let average = audioPlayer.averagePower(forChannel: i)
            power += average
            // print("average", average)
            
            // let peak = audioPlayer.peakPower(forChannel: i)
            // power += peak
            // print("peak", peak)
        }
        power /= Float(channels)
        
        // print("power", power)

        let level = meterTable.ValueAt(power)
        print("level", level)
        
        // if power < -5.5 {
        if level > 0.8 {
            sparkNode.particleBirthRate = 2000.0
        } else {
            sparkNode.particleBirthRate = 10.0
        }
        
    }
}
