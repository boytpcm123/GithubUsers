//
//  NetworkManagerMock.swift
//  GithubUsersTests
//
//  Created by Thong Nguyen on 23/7/24.
//

import Foundation
@testable import GithubUsers

final class NetworkManagerMock {
    var apiManager: APIManagerProtocol

    init(apiManager: APIManagerProtocol) {
        self.apiManager = apiManager
    }
}

extension NetworkManagerMock: NetworkManagerProtocol {
    func initRequest<T: Decodable>(with endPoint: EndPoint) async throws -> T {
        let data = try await apiManager.initRequest(with: endPoint)
        let decoded: T = try parser.parse(data: data)
        return decoded
    }
}
