//
//  GithubUserDetailViewModelTests.swift
//  GithubUsersTests
//
//  Created by Thong Nguyen on 23/7/24.
//

import XCTest
@testable import GithubUsers

@MainActor
final class GithubUserDetailViewModelTests: XCTestCase {

    let testContext = PersistenceController.preview.container.newBackgroundContext()

    var uat: GithubUserDetailViewModel!

    override func setUpWithError() throws {
        try super.setUpWithError()

        uat = GithubUserDetailViewModel(
            userLogin: UserDetail.mock.login,
            userDetailFetchable: UserDetailFetchableMock(),
            userDetailStore: UserDetailStoreService(context: testContext)
        )
    }

    override func tearDownWithError() throws {
        uat = nil

        try super.tearDownWithError()
    }

    func testUserDetailLoginNameWhenInit() async {
        XCTAssertEqual(uat.userLogin, UserDetail.mock.login, "The view model's userLogin should be \(UserDetail.mock.login), but it is \(uat.userLogin)")
    }

    func testFetchUserDetailLoadingState() async {
        XCTAssertEqual(uat.isLoading, true, "The view model should be loading, but it isn't")
        await uat.fetchData()
        XCTAssertEqual(uat.isLoading, false, "The view model shouldn't be loading, but it is")
    }
}
