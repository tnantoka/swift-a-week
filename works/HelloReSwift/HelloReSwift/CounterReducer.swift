//
//  CounterReducer.swift
//  HelloReSwift
//
//  Created by Tatsuya Tobioka on 10/29/16.
//  Copyright © 2016 tnantoka. All rights reserved.
//

import Foundation

import ReSwift

struct CounterReducer: Reducer {
    
    func handleAction(action: Action, state: AppState?) -> AppState {
        var state = state ?? AppState()
        
        switch action {
        case _ as CounterActionIncrease:
            state.counter += 1
        case _ as CounterActionDecrease:
            state.counter -= 1
        default:
            break
        }
        
        return state
    }
}
