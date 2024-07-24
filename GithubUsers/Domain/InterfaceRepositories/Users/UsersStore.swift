//
//  UsersStore.swift
//  GithubUsers
//
//  Created by Thong Nguyen on 22/7/24.
//

import Foundation

protocol UsersStore: Sendable {
    func save(users: [User]) async throws
}
