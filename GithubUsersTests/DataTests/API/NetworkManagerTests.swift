//
//  NetworkManagerMock.swift
//  GithubUsersTests
//
//  Created by Thong Nguyen on 23/7/24.
//

import XCTest
@testable import GithubUsers

final class NetworkManagerTests: XCTestCase {
    private var networkManager: NetworkManagerProtocol?

    override func setUpWithError() throws {
        try super.setUpWithError()

        networkManager = NetworkManagerMock(
            apiManager: APIManagerMock()
        )
    }

    func testRequestUsers() async throws {
        guard let users: [User] = try await networkManager?.initRequest(with: UsersEndPointMock.getUsers) else { return }

        let first = users.first

        XCTAssertEqual(first?.id, 1)
        XCTAssertEqual(first?.login, "mojombo")
        XCTAssertEqual(first?.avatarUrl, "https://avatars.githubusercontent.com/u/1?v=4")
        XCTAssertEqual(first?.htmlUrl, "https://github.com/mojombo")

        let last = users.last

        XCTAssertEqual(last?.id, 135)
        XCTAssertEqual(last?.login, "richcollins")
        XCTAssertEqual(last?.avatarUrl, "https://avatars.githubusercontent.com/u/135?v=4")
        XCTAssertEqual(last?.htmlUrl, "https://github.com/richcollins")
    }

    func testRequestUserDetail() async throws {
        guard let userDetail: UserDetail = try await networkManager?.initRequest(with: UsersEndPointMock.getUserDetail) else { return }

        XCTAssertEqual(userDetail.id, 1)
        XCTAssertEqual(userDetail.login, "mojombo")
        XCTAssertEqual(userDetail.avatarUrl, "https://avatars.githubusercontent.com/u/1?v=4")
        XCTAssertEqual(userDetail.htmlUrl, "https://github.com/mojombo")
        XCTAssertEqual(userDetail.location, "Vietnam")
        XCTAssertEqual(userDetail.followers, 23961)
        XCTAssertEqual(userDetail.followersText, "100+")
        XCTAssertEqual(userDetail.following, 11)
        XCTAssertEqual(userDetail.followingText, "10+")
    }
}
