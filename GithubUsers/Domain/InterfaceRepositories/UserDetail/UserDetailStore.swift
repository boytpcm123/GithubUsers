//
//  UserDetailStore.swift
//  GithubUsers
//
//  Created by Thong Nguyen on 22/7/24.
//

import Foundation

protocol UserDetailStore {
    func save(user: UserDetail?) async throws
}
