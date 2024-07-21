//
//  UsersEndPoint.swift
//  GithubUsers
//
//  Created by Thong Nguyen on 21/7/24.
//

import Foundation

struct UsersEndPoint: EndPoint {

    let perPage: String
    let since: String

    init(perPage: Int, since: Int) {
        self.perPage = "\(perPage)"
        self.since = "\(since)"
    }

    var path: String {
        "/users"
    }

    var urlParams: [String: String?] {
        [
            "per_page": perPage,
            "since": since
        ]
    }
}
