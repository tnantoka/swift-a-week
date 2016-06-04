//: Playground - noun: a place where people can play

import UIKit
import XCPlayground
import AVFoundation

class Speech {
    let string = "この世に悪があるとすれば、それは人の心だ。"
//    let string = "If there is evil in the world, it lurks in the hearts of man."
    
//    let language = "en_US"
    let language = "ja_JP"
    
    @objc
    func speech() {
        let synthesizer = AVSpeechSynthesizer()
        
        let utterance = AVSpeechUtterance(string: string)
        
        //  Speech rates are values in the range between AVSpeechUtteranceMinimumSpeechRate and AVSpeechUtteranceMaximumSpeechRate. Lower values correspond to slower speech, and vice versa. The default value is AVSpeechUtteranceDefaultSpeechRate.
        utterance.rate = AVSpeechUtteranceDefaultSpeechRate
        utterance.rate = AVSpeechUtteranceDefaultSpeechRate
//        print(AVSpeechUtteranceMinimumSpeechRate) // 0.0
//        print(AVSpeechUtteranceDefaultSpeechRate) // 0.5
//        print(AVSpeechUtteranceMaximumSpeechRate) // 1.0
        
        //  The default pitch is 1.0. Allowed values are in the range from 0.5 (for lower pitch) to 2.0 (for higher pitch).
        utterance.pitchMultiplier = 1.0
        
        //  Allowed values are in the range from 0.0 (silent) to 1.0 (loudest). The default volume is 1.0.
        utterance.volume = 1.0
        
        let voice = AVSpeechSynthesisVoice(language: language)
        utterance.voice = voice
        
        synthesizer.speakUtterance(utterance)
    }
}

let speech = Speech()

let view = UIView(frame: CGRect(x: 0, y: 0, width: 300, height: 50))
view.backgroundColor = UIColor.whiteColor()

let button = UIButton(type: .System)
button.setTitle("Speech", forState: .Normal)
button.frame = view.bounds
button.addTarget(speech, action:  #selector(Speech.speech), forControlEvents: .TouchUpInside)
view.addSubview(button)

XCPlaygroundPage.currentPage.liveView = view

