//
//  ServerTests.swift
//  HelloVapor
//
//  Created by Tatsuya Tobioka on 2/27/16.
//  Copyright © 2016 Tatsuya Tobioka. All rights reserved.
//

import XCTest
@testable import HelloVapor
@testable import Vapor

class ServerTests: XCTestCase {

    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }

    func testStart() {
        let server = Server()
        server.app.bootRoutes()

        let request = Request(
            method: .Get,
            path: "welcome",
            address: nil,
            headers: ["host": "example.com"],
            body: []
        )
        
        do {
            let result = server.app.router.route(request)!
            var bytes = try result(request: request).data
            
            let utf8 = NSData(bytes: &bytes , length: bytes.count)
            let string = String(data: utf8, encoding: NSUTF8StringEncoding)
            XCTAssert(string == "<html><meta charset=\"UTF-8\"><body>Hello</body></html>")
        } catch {
            XCTFail()
        }
    }
}
