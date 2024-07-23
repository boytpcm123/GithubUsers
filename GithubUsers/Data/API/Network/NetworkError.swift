//
//  NetworkError.swift
//  GithubUsers
//
//  Created by Thong Nguyen on 21/7/24.
//

import Foundation

enum NetworkError: LocalizedError {
    case invalidServerResponse
    case invalidURL
    case unexpectedStatusCode
    case decodingFailed
    case customError(ErrorModel)
    public var errorDescription: String? {
        switch self {
        case .invalidServerResponse:
            return "The server returned an invalid response."
        case .invalidURL:
            return "URL string is malformed."
        case .unexpectedStatusCode:
            return "Server is not reachable."
        case .decodingFailed:
            return "Failed to decode data."
        case .customError(let model):
            return model.message
        }
    }
}

// For custom erors
struct ErrorModel: Codable {
    let code: String?
    let message: String?
}
