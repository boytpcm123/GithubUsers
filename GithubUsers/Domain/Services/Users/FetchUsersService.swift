//
//  FetchUsersService.swift
//  GithubUsers
//
//  Created by Thong Nguyen on 21/7/24.
//

import Foundation

actor FetchUsersService {
    private let networkManager: NetworkManagerProtocol

    init(networkManager: NetworkManagerProtocol = NetworkManager()) {
        self.networkManager = networkManager
    }
}

// MARK: - UsersFetchable
extension FetchUsersService: UsersFetchable {
    func fetchUsers(perPage: Int, since: Int64) async throws -> [User] {
        let requestData = UsersEndPoint.getUsersWith(perPage: perPage, since: since)

        do {
            let users: [User] = try await self.networkManager.initRequest(with: requestData)
            return users
        } catch {
            print(error.localizedDescription)
            return []
        }
    }
}
