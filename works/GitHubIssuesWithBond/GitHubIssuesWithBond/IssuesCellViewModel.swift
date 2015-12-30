//
//  IssuesCellViewModel.swift
//  GitHubIssuesWithBond
//
//  Created by Tatsuya Tobioka on 2015/12/29.
//  Copyright © 2015年 tnantoka. All rights reserved.
//

import Foundation

import Bond

class IssuesCellViewModel {
    let title = Observable<String?>(nil)
    let detail = Observable<String?>(nil)
    let htmlURL: NSURL?
    
    init(issue: Issue) {
        self.htmlURL = issue.htmlURL
        guard let htmlURL = htmlURL else { return }
        let repo = htmlURL.absoluteString.stringByReplacingOccurrencesOfString(
            "^https://github.com/|/(?:issues|pull)/\\d+$",
            withString: "",
            options: [.RegularExpressionSearch, .CaseInsensitiveSearch],
            range: nil
        )
        title.value = "[\(repo)] #\(issue.number) \(issue.title)"
        detail.value = "\(issue.labels.map { $0.name }.joinWithSeparator(", ")) \(issue.body ?? "")"
    }
}