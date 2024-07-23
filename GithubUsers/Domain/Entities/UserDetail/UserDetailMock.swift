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
    guard let userDetail: UserDetail = DataParser().getJsonDataFrom(fileName: "UserDetailMock") else {
        return UserDetail.mockDefault
    }
    return userDetail
}
