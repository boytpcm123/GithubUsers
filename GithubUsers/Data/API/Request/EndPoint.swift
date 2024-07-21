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
}

enum RequestMethod: String {
    case get
    case post
    case put
    case delete
    case patch
}
