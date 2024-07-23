//
//  UsersFetchableMock.swift
//  GithubUsers
//
//  Created by Thong Nguyen on 22/7/24.
//

import Foundation

struct UsersFetchableMock: UsersFetchable {
    func fetchUsers(perPage: Int, since: Int64) async throws -> [User] {
        User.mockList
    }
}
