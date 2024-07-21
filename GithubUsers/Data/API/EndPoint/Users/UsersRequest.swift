//
//  UsersEndPoint.swift
//  GithubUsers
//
//  Created by Thong Nguyen on 21/7/24.
//

import Foundation

enum UsersEndPoint: EndPoint {
    case getUsersWith(perPage: Int, since: Int)
    case getUserDetailWith(login: String)

    var path: String {
        switch self {
        case .getUsersWith:
            return "/users"
        case let .getUserDetailWith(login):
            return "/users/\(login)"
        }
    }

    var urlParams: [String: String?] {
        switch self {
        case .getUsersWith(perPage: let perPage, since: let since):
            let params = [
                "per_page": String(perPage),
                "since": String(since)
            ]
            return params
        default:
            return [:]
        }
    }
}
