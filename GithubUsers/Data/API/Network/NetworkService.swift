//
//  NetworkService.swift
//  GithubUsers
//
//  Created by Thong Nguyen on 21/7/24.
//

import Foundation
import Combine

final class NetworkService: NetworkAble {

    private let urlSession: URLSession

    init(urlSession: URLSession = URLSession.shared) {
        self.urlSession = urlSession
    }

    func sendRequest<T: Decodable>(endPoint: any EndPoint, type: T.Type) async throws -> T {
        guard let urlRequest = createRequest(endPoint: endPoint) else {
            throw NetworkError.invalidURL
        }

        do {
            let (data, response) = try await urlSession.data(for: urlRequest)

            guard let response = response as? HTTPURLResponse,
                  200...299 ~= response.statusCode else {
                throw NetworkError.unexpectedStatusCode
            }

            guard let value = try? parser.parse(data: data, type: T.self) else {
                throw NetworkError.decodingFailed
            }

            return value
        } catch let error {
            throw NetworkError.customError(ErrorModel(code: nil, message: error.localizedDescription))
        }
    }
}
