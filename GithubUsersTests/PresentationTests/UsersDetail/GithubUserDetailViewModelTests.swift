//
//  GithubUserDetailViewModelTests.swift
//  GithubUsersTests
//
//  Created by Thong Nguyen on 23/7/24.
//

import XCTest
@testable import GithubUsers

final class GithubUserDetailViewModelTests: XCTestCase {

    let testContext = PersistenceController.preview.container.newBackgroundContext()

    var uat: GithubUserDetailViewModel!

    @MainActor
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

    @MainActor
    func testUserDetailLoginNameWhenInit() async {
        let testUserLogin: String = "mojombo"
        XCTAssertEqual(
            uat.userLogin, testUserLogin, 
            "The view model's userLogin should be \(testUserLogin), but it is \(uat.userLogin)"
        )
    }

    @MainActor
    func testFetchUserDetailLoadingState() async {
        XCTAssertEqual(uat.isLoading, true, "The view model should be loading, but it isn't")
        await uat.fetchData()
        XCTAssertEqual(uat.isLoading, false, "The view model shouldn't be loading, but it is")
    }
}
