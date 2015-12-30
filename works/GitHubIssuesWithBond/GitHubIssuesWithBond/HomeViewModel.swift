//
//  HomeViewModel.swift
//  GitHubIssuesWithBond
//
//  Created by Tatsuya Tobioka on 2015/12/26.
//  Copyright © 2015年 tnantoka. All rights reserved.
//

import Foundation

import Bond
import GitHubAuth
import APIKit

enum HomeState {
    case SignedOut, SignedIn
}

class HomeViewModel {
    let avatar = Observable<UIImage?>(nil)
    let username = Observable<String?>(nil)
    let state = Observable<HomeState>(.SignedOut)
    
    init() {
        state.observeNew { [unowned self] state in
            switch state {
            case .SignedOut:
                self.avatar.value = nil
                self.username.value = nil
            case .SignedIn:
                let request = GetUserRequest()
                Session.sendRequest(request) { result in
                    switch result {
                    case .Success(let user):
                        self.username.value = user.login
                        
                        guard let avatarURL = user.avatarURL else { return }
                        let session = NSURLSession.sharedSession()
                        let task = session.dataTaskWithURL(avatarURL) { data, response, error in
                            guard let data = data else { return }
                            dispatch_async(dispatch_get_main_queue()) {
                                self.avatar.value = UIImage(data: data)
                            }
                        }
                        task.resume()
                        
                    case .Failure(let error):
                        print(error)
                    }
                }
            }
        }
        if GitHubAuth.shared.isSignedIn {
            state.value = .SignedIn
        }
    }
    
    func signIn() {
        GitHubAuth.shared.signIn { error in
            self.state.value = .SignedIn
        }
    }
    
    func signOut() {
        GitHubAuth.shared.signOut()
        state.value = .SignedOut
    }
}
