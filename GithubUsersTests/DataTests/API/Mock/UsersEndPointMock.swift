//
//  UsersEndPointMock.swift
//  GithubUsersTests
//
//  Created by Thong Nguyen on 23/7/24.
//

import Foundation
@testable import GithubUsers

enum UsersEndPointMock: EndPoint {
    case getUsers
    case getUserDetail

    var path: String {
        switch self {
        case .getUsers:
            return Bundle.main.path(forResource: "UsersMock", ofType: "json") ?? ""
        case .getUserDetail:
            return Bundle.main.path(forResource: "UserDetailMock", ofType: "json") ?? ""
        }
    }
}
