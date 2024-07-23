//
//  User.swift
//  GithubUsers
//
//  Created by Thong Nguyen on 20/7/24.
//

import Foundation

protocol UserProtocol {
    var id: Int64 { get }
    var login: String { get }
    var avatarUrl: String? { get }
    var htmlUrl: String? { get }
}

struct User: UserProtocol, Codable {
    var id: Int64
    let login: String
    let avatarUrl: String?
    let htmlUrl: String?
}

extension User: Identifiable {}
