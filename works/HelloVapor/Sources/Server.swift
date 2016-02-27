//
//  Server.swift
//  HelloVapor
//
//  Created by Tatsuya Tobioka on 2/27/16.
//  Copyright © 2016 Tatsuya Tobioka. All rights reserved.
//

import Vapor

struct Server {
    let app = Application()
    
    init() {
        app.get("welcome") { request in
            return "Hello"
        }
    }
    
    func start() {
        app.start(port: 8080)
    }
}