//
//  EndPoint.swift
//  GithubUsers
//
//  Created by Thong Nguyen on 21/7/24.
//

import Foundation

protocol EndPoint {
    var host: String { get }
    var scheme: String { get }
    var path: String { get }
    var method: RequestMethod { get }
    var params: [String: Any] { get }
    var urlParams: [String: String?] { get }
    var headers: [String: String] { get }
    var body: [String: String]? { get }
}

extension EndPoint {
    var host: String {
        APIConstants.host
    }

    var scheme: String {
        "https"
    }

    var method: RequestMethod {
        .get
    }

    var params: [String: Any] {
      [:]
    }

    var urlParams: [String: String?] {
      [:]
    }

    var headers: [String: String] {
      [:]
    }

    var body: [String: String]? {
        nil
    }

    func createRequest() -> URLRequest? {
        var urlComponents = URLComponents()
        urlComponents.scheme = scheme
        urlComponents.host = host
        urlComponents.path = path

        if !urlParams.isEmpty {
            urlComponents.queryItems = urlParams.map { URLQueryItem(name: $0, value: $1) }
        }

        guard let url = urlComponents.url else {
            return nil
        }

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        urlRequest.allHTTPHeaderFields = headers

        if !headers.isEmpty {
            urlRequest.allHTTPHeaderFields = headers
        }

        urlRequest.setValue("application/json;charset=utf-8", forHTTPHeaderField: "Content-Type")

        if !params.isEmpty {
            urlRequest.httpBody = try? JSONSerialization.data(withJSONObject: params)
        }

        if let body = body {
            urlRequest.httpBody = try? JSONEncoder().encode(body)
        }
        return urlRequest
    }
}
