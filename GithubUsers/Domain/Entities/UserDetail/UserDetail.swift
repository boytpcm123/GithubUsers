//
//  UserDetail.swift
//  GithubUsers
//
//  Created by Thong Nguyen on 20/7/24.
//

import Foundation

struct UserDetail: Codable {
    let id: Int64
    let login: String
    let avatarUrl: String
    let htmlUrl: String
    let location: String
    let followers: String
    let following: String
}
