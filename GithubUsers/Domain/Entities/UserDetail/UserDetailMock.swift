//
//  UserDetailMock.swift
//  GithubUsers
//
//  Created by Thong Nguyen on 21/7/24.
//

import Foundation

// MARK: - Mock Data
extension UserDetail {
    static let mock = loadUserDetail()
    static let mockDefault = UserDetail(
        id: 1,
        login: "mojombo",
        avatarUrl: "https://avatars.githubusercontent.com/u/1?v=4",
        htmlUrl: "https://github.com/mojombo",
        location: "San Francisco",
        followers: 23957,
        following: 11
    )
}

private func loadUserDetail() -> UserDetail {
    guard let url = Bundle.main.url(forResource: "UserMock", withExtension: "json"),
          let data = try? Data(contentsOf: url) else {
        print("Failed to decode JSON mock data")
        return UserDetail.mockDefault
    }

    do {
        // Decode the JSON data
        let userDetail = try DataParser().parse(data: data, type: UserDetail.self)

        // Print the user to verify
        // print(userDetail)

        return userDetail
    } catch {
        print("Failed to decode JSON: \(error.localizedDescription)")
    }

    return UserDetail.mockDefault
}
