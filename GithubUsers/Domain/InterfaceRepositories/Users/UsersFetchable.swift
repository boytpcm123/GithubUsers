//
//  UsersRepository.swift
//  GithubUsers
//
//  Created by Thong Nguyen on 21/7/24.
//

import Foundation

protocol UsersFetchable: Sendable {
    func fetchUsers(perPage: Int, since: Int64) async throws -> [User]
}
