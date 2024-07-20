//
//  User.swift
//  GithubUsers
//
//  Created by Thong Nguyen on 20/7/24.
//

import Foundation

struct User: Codable {
    let id: Int64
    let login: String
    let avatarUrl: String
    let htmlUrl: String
}

extension User: Identifiable {}
