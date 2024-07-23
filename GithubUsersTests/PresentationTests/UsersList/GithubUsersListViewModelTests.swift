//
//  GithubUsersListViewModelTests.swift
//  GithubUsersTests
//
//  Created by Thong Nguyen on 23/7/24.
//

import XCTest
@testable import GithubUsers

@MainActor
final class GithubUsersListViewModelTests: XCTestCase {

    let testContext = PersistenceController.preview.container.newBackgroundContext()

    var uat: GithubUsersListViewModel!

    override func setUpWithError() throws {
        try super.setUpWithError()

        uat = GithubUsersListViewModel(
            usersFetchable: UsersFetchableMock(),
            usersStore: UsersStoreService(
                context: testContext
            )
        )
    }

    override func tearDownWithError() throws {
        uat = nil
        try super.tearDownWithError()
    }

    func testFetchUsersLoadingState() async {
        XCTAssertEqual(uat.isLoading, true, "The view model should be loading, but it isn't")
        await uat.fetchData()
        XCTAssertEqual(uat.isLoading, false, "The view model shouldn't be loading, but it is")
    }

    func testRefreshFetchUsers() async {
        let refreshID = uat.refreshID
        await uat.refresh()
        XCTAssertNotEqual(uat.refreshID, refreshID, "The view model's refreshID shouldn't be equal, but it is")
    }

    func testUpdateSinceOnFetchMoreUsers() async {
        XCTAssertEqual(
            uat.since, 0,
            "The view model's since property should be 0 before fetching, but it's \(uat.since)"
        )
        await uat.fetchMoreUsers(since: 30)
        XCTAssertEqual(
            uat.since, 30,
            "The view model's since property should be 30 after fetching, but it's \(uat.since)"
        )
    }

    func testFetchUsersEmptyResponse() async {
        uat = GithubUsersListViewModel(
            usersFetchable: EmptyResponseUsersFetcherMock(),
            usersStore: UsersStoreService(
                context: testContext
            )
        )

        XCTAssertEqual(
            uat.hasMoreUsers, true,
            "hasMoreUsers should be true, but it isn't"
        )
        XCTAssertEqual(
            uat.isLoading, true,
            "The view model should be loading, but it isn't"
        )

        await uat.fetchData()
        XCTAssertEqual(
            uat.hasMoreUsers, false,
            "hasMoreUsers should be false with an empty response, but it's true"
        )
        XCTAssertEqual(
            uat.isLoading, false,
            "The view model shouldn't be loading after receiving an empty response, but it is"
        )
    }
}

struct EmptyResponseUsersFetcherMock: UsersFetchable {
    func fetchUsers(perPage: Int, since: Int64) async throws -> [User] {
        return []
    }
}
