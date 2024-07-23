//
//  UserDetailFetchableMock.swift
//  GithubUsers
//
//  Created by Thong Nguyen on 22/7/24.
//

import Foundation

struct UserDetailFetchableMock: UserDetailFetchable {
    func fetchUserDetail(login: String) async throws -> UserDetail? {
        UserDetail.mock
    }
}
