//
//  UserMock.swift
//  GithubUsers
//
//  Created by Thong Nguyen on 20/7/24.
//

import Foundation

// MARK: - Mock Data
extension User {
    static let mockList = loadUsers()
}

private func loadUsers() -> [User] {
    guard let users: [User] = DataParser().getJsonDataFrom(fileName: "UsersMock") else {
        return []
    }
    return users
}
