//
//  NetworkManager.swift
//  GithubUsers
//
//  Created by Thong Nguyen on 21/7/24.
//

import Foundation

protocol NetworkManagerProtocol: Sendable {
    var apiManager: APIManagerProtocol { get }
    var parser: DataParserProtocol { get }
    func initRequest<T: Decodable>(with endPoint: EndPoint) async throws -> T
}

// MARK: - Returns Data Parser
extension NetworkManagerProtocol {
    var parser: DataParserProtocol {
        return DataParser()
    }
}

final class NetworkManager {
    let apiManager: APIManagerProtocol

    init(apiManager: APIManagerProtocol = APIManager()) {
        self.apiManager = apiManager
    }
}

extension NetworkManager: NetworkManagerProtocol {
    func initRequest<T: Decodable>(with endPoint: EndPoint) async throws -> T {
        let data = try await apiManager.initRequest(with: endPoint)
        let decoded: T = try parser.parse(data: data)
        return decoded
    }
}
