//
//  UserDetail.swift
//  GithubUsers
//
//  Created by Thong Nguyen on 20/7/24.
//

import Foundation

protocol UserDetailProtocol: UserProtocol {
    var location: String { get }
    var followers: Int { get }
    var following: Int { get }
}

struct UserDetail: UserDetailProtocol, Codable {
    let login: String
    let avatarUrl: String
    let htmlUrl: String
    let location: String
    let followers: Int
    let following: Int
}
