//
//  APIManagerMock.swift
//  GithubUsersTests
//
//  Created by Thong Nguyen on 23/7/24.
//

import Foundation
@testable import GithubUsers

final class APIManagerMock: APIManagerProtocol {
    func initRequest(with endPoint: EndPoint) async throws -> Data {
        try Data(contentsOf: URL(fileURLWithPath: endPoint.path), options: .mappedIfSafe)
    }
}
