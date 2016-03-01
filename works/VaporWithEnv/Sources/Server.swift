//
//  Server.swift
//  HelloVapor
//
//  Created by Tatsuya Tobioka on 2/27/16.
//  Copyright © 2016 Tatsuya Tobioka. All rights reserved.
//

import Vapor
import Foundation

struct Server {
    let app = Application()
    
    init() {
        app.get("") { request in
            let test = NSProcessInfo.processInfo().environment["TEST"] ?? ""
            return "Hello \(test)"
        }
    }
    
    func start() {
        app.start(port: 8081)
    }
}