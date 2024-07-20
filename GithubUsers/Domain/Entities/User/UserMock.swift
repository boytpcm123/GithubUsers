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
    guard let url = Bundle.main.url(forResource: "UsersMock", withExtension: "json"),
          let data = try? Data(contentsOf: url) else {
        print("Failed to decode JSON mock data")
        return []
    }

    do {
        // Decode the JSON data
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let users = try decoder.decode([User].self, from: data)

        // Print the users to verify
//        for user in users {
//            print("ID: \(user.id), Login: \(user.login), Avatar URL: \(user.avatarUrl), HTML URL: \(user.htmlUrl)")
//        }

        return users
    } catch {
        print("Failed to decode JSON: \(error.localizedDescription)")
    }

    return []
}
