//
//  Server.swift
//  VaporWithMyLib
//
//  Created by Tatsuya Tobioka on 2/27/16.
//  Copyright © 2016 Tatsuya Tobioka. All rights reserved.
//

import Foundation
import Vapor
import Symday

struct Server {
    let app = Application()
    
    init() {
        app.get("") { request in
            let date = Symday().format(NSDate())
            return "Hello \(date)"
        }
    }
    
    func start() {
        app.start(port: 8083)
    }
}
