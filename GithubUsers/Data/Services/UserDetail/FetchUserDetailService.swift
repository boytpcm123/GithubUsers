//
//  FetchUsersService.swift
//  GithubUsers
//
//  Created by Thong Nguyen on 21/7/24.
//

import Foundation

actor FetchUserDetailService {
    private let networkManager: NetworkManagerProtocol

    init(networkManager: NetworkManagerProtocol = NetworkManager()) {
        self.networkManager = networkManager
    }
}

// MARK: - UsersFetchable
extension FetchUserDetailService: UserDetailFetchable {
    func fetchUserDetail(login: String) async throws -> UserDetail? {
        let requestData = UsersEndPoint.getUserDetailWith(login: login)

        do {
            let user: UserDetail = try await self.networkManager.initRequest(with: requestData)
            return user
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
}
