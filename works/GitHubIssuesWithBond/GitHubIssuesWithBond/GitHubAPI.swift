//
//  GitHubAPI.swift
//  GitHubIssuesWithBond
//
//  Created by Tatsuya Tobioka on 2015/12/28.
//  Copyright © 2015年 tnantoka. All rights reserved.
//

import Foundation

import APIKit
import Himotoki
import GitHubAuth

protocol GitHubRequest: RequestType {
    
}

extension GitHubRequest {
    var method: HTTPMethod {
        return .GET
    }

    var baseURL: NSURL {
        return NSURL(string: "https://api.github.com")!
    }
    
    func configureURLRequest(URLRequest: NSMutableURLRequest) throws -> NSMutableURLRequest {
        if GitHubAuth.shared.isSignedIn {
            GitHubAuth.shared.authorize(URLRequest)
        }
        return URLRequest
    }
}

extension GitHubRequest where Self.Response: Decodable, Self.Response == Self.Response.DecodedType {
    func responseFromObject(object: AnyObject, URLResponse: NSHTTPURLResponse) -> Self.Response? {
        return try? decode(object)
    }
}

// MARK: - Users

struct User: Decodable {
    let id: Int
    let login: String
    let avatarURL: NSURL?
    
    static func decode(e: Extractor) throws -> User {
        return try build(self.init)(
            e.value("id"),
            e.value("login"),
            e.valueOptional("avatar_url").flatMap { NSURL(string: $0) }
        )
    }
}

struct GetUserRequest: GitHubRequest {
    typealias Response = User
    
    var path: String {
        return "/user"
    }
}

// MARK: - Issues

struct Label: Decodable {
    let name: String
    let color: String
    
    static func decode(e: Extractor) throws -> Label {
        return try build(self.init)(
            e.value("name"),
            e.value("color")
        )
    }
}

struct Issue: Decodable {
    let id: Int
    let htmlURL: NSURL?
    let number: Int
    let title: String
    let body: String?
    let labels: [Label]
    
    static func decode(e: Extractor) throws -> Issue {
        return try build(self.init)(
            e.value("id"),
            e.valueOptional("html_url").flatMap { NSURL(string: $0) },
            e.value("number"),
            e.value("title"),
            e.valueOptional("body"),
            e.array("labels")
        )
    }
}

struct PaginatedResponse<T> {
    var results: [T]
    var hasNext: Bool
    
    init(results: [T], URLResponse: NSHTTPURLResponse) {
        self.results = results
        hasNext = (URLResponse.allHeaderFields["Link"] as? String)?.containsString("rel=\"next\"") ?? false
    }
}

struct GetIssuesRequest: GitHubRequest {
    typealias Response = PaginatedResponse<Issue>
    
    var path: String {
        return "/issues"
    }
    
    var parameters: [String: AnyObject] {
        return [
            "per_page": 20,
            "filter": "all",
            "page": page
        ]
    }
    
    let page: Int
    
    func responseFromObject(object: AnyObject, URLResponse: NSHTTPURLResponse) -> Response? {
        guard let results = try? decodeArray(object) as [Issue] else { return nil }
        return PaginatedResponse(results: results, URLResponse: URLResponse)
    }
}

