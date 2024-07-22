//
//  User.swift
//  GithubUsers
//
//  Created by Thong Nguyen on 20/7/24.
//

import Foundation

protocol UserProtocol {
    var id: Int { get }
    var login: String { get }
    var avatarUrl: String { get }
    var htmlUrl: String { get }
}

struct User: UserProtocol, Codable {
    var id: Int
    let login: String
    let avatarUrl: String
    let htmlUrl: String
}

extension User: Identifiable {}
