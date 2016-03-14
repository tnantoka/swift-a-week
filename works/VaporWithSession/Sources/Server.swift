//
//  Server.swift
//  VaporWithSession
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
            let count = (Int(request.session?["count"] ?? "") ?? 0) + 1
            request.session?["count"] = "\(count)"
            return "Hello \(count)"
        }
    }
    
    func start() {
        app.start(port: 8082)
    }
}
