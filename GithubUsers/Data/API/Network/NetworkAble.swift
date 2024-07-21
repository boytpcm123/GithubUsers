//
//  NetworkAble.swift
//  GithubUsers
//
//  Created by Thong Nguyen on 21/7/24.
//

import Foundation
import Combine

protocol NetworkAble {
    func sendRequest<T: Decodable>(endPoint: EndPoint, type: T.Type) async throws -> T
}

extension NetworkAble {
    func createRequest(endPoint: EndPoint) -> URLRequest? {
        var urlComponents = URLComponents()
        urlComponents.scheme = endPoint.scheme
        urlComponents.host = endPoint.host
        urlComponents.path = endPoint.path

        if !endPoint.urlParams.isEmpty {
            urlComponents.queryItems = endPoint.urlParams.map { URLQueryItem(name: $0, value: $1) }
        }

        guard let url = urlComponents.url else {
            return nil
        }

        let encoder = JSONEncoder()
        var request = URLRequest(url: url)
        request.httpMethod = endPoint.method.rawValue
        request.allHTTPHeaderFields = endPoint.headers

        if !endPoint.headers.isEmpty {
            request.allHTTPHeaderFields = endPoint.headers
        }

        request.setValue("application/json;charset=utf-8", forHTTPHeaderField: "Content-Type")

        if !endPoint.params.isEmpty {
            request.httpBody = try? JSONSerialization.data(withJSONObject: endPoint.params)
        }

        if let body = endPoint.body {
            request.httpBody = try? encoder.encode(body)
        }
        return request
    }

    var parser: DataParserProtocol {
        return DataParser()
    }
}
