//
//  UserDetailFetchable.swift
//  GithubUsers
//
//  Created by Thong Nguyen on 21/7/24.
//

import Foundation

protocol UserDetailFetchable {
    func fetchUserDetail(login: String) async throws -> UserDetail?
}
