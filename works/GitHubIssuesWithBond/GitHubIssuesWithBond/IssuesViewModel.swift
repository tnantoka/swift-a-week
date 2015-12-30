//
//  IssuesViewModel.swift
//  GitHubIssuesWithBond
//
//  Created by Tatsuya Tobioka on 2015/12/29.
//  Copyright © 2015年 tnantoka. All rights reserved.
//

import Foundation

import Bond
import GitHubAuth
import APIKit

class IssuesViewModel {
    let cellViewModels = ObservableArray<IssuesCellViewModel>()
    
    var page = 0
    var hasNext = true
    
    init() {
        loadNext()
    }
    
    func loadNext() {
        if !hasNext {
            return
        }
        page += 1
        let request = GetIssuesRequest(page: page)
        Session.sendRequest(request) { result in
            switch result {
            case .Success(let response):
                self.hasNext = response.hasNext
                var cellVMs = [IssuesCellViewModel]()
                response.results.forEach { issue in
                    let cellVM = IssuesCellViewModel(issue: issue)
                    cellVMs.append(cellVM)
                }
                self.cellViewModels.insertContentsOf(cellVMs, atIndex: self.cellViewModels.count)
            case .Failure(let error):
                print(error)
            }
        }
    }
}
