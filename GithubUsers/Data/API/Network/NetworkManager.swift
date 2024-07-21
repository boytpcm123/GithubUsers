//
//  NetworkManager.swift
//  GithubUsers
//
//  Created by Thong Nguyen on 21/7/24.
//

import Foundation

final class NetworkManager {
    let networkService: NetworkAble

    init(networkService: NetworkAble = NetworkService()) {
        self.networkService = networkService
    }
}

extension NetworkManager: UsersFetchable {
    func fetchUsers(perPage: Int, since: Int) async throws -> [User] {
        let endpoint = UsersEndPoint(perPage: perPage, since: since)
        return try await self.networkService.sendRequest(endPoint: endpoint, type: [User].self)
    }
}
