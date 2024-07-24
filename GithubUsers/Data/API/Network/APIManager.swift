//
//  NetworkService.swift
//  GithubUsers
//
//  Created by Thong Nguyen on 21/7/24.
//

import Foundation
import Combine

protocol APIManagerProtocol: Sendable {
  func initRequest(with data: EndPoint) async throws -> Data
}

final class APIManager: APIManagerProtocol {

    private let urlSession: URLSession

    init(urlSession: URLSession = URLSession.shared) {
        self.urlSession = urlSession
    }

    func initRequest(with endPoint: EndPoint) async throws -> Data {
        guard let urlRequest = endPoint.createRequest() else {
            throw NetworkError.invalidURL
        }

        do {
            let (data, response) = try await urlSession.data(for: urlRequest)

            guard let response = response as? HTTPURLResponse,
                  200...299 ~= response.statusCode else {
                throw NetworkError.unexpectedStatusCode
            }

            return data
        } catch let error {
            throw NetworkError.customError(ErrorModel(code: nil, message: error.localizedDescription))
        }
    }
}
