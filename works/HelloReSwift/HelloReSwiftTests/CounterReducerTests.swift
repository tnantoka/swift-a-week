//
//  CounterReducerTests.swift
//  HelloReSwift
//
//  Created by Tatsuya Tobioka on 10/29/16.
//  Copyright © 2016 tnantoka. All rights reserved.
//

import XCTest

@testable import HelloReSwift

class CounterReducerTests: XCTestCase {
    
    let reducer = CounterReducer()
    let state = AppState()

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testIncrease() {
        let nextState = reducer.handleAction(action: CounterActionIncrease(), state: state)
        XCTAssertEqual(nextState.counter, state.counter + 1)
    }
    
    func testDecrease() {
        let nextState = reducer.handleAction(action: CounterActionDecrease(), state: state)
        XCTAssertEqual(nextState.counter, state.counter - 1)
    }
}
