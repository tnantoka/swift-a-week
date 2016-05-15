//
//  HelloSwift.swift
//  HelloWorld
//
//  Created by Tatsuya Tobioka on 5/15/16.
//  Copyright © 2016 Facebook. All rights reserved.
//

import Foundation

@objc(HelloSwift)
class HelloSwift: NSObject {
  
  @objc func hello(message: String, callback: RCTResponseSenderBlock) {
    callback(["Hello, \(message)"])
  }
}