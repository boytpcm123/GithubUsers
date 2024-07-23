//
//  CoreDataTests.swift
//  GithubUsersTests
//
//  Created by Thong Nguyen on 23/7/24.
//

import XCTest
import CoreData
@testable import GithubUsers

final class CoreDataTests: XCTestCase {

    func testFetchUsersAndDeleteManagedObject() throws {
        let previewContext = PersistenceController.preview.container.viewContext

        let fetchRequest = UserEntity.fetchRequest()

        guard let results = try? previewContext.fetch(fetchRequest),
              let first = results.first else { return }

        var testNumberResult = 100
        XCTAssertEqual(results.count, testNumberResult, "The number of results was expected \(testNumberResult), but it is \(results.count)")

        previewContext.delete(first)

        guard let results = try? previewContext.fetch(fetchRequest)
          else { return }

        testNumberResult -= 1
        XCTAssertEqual(results.count, testNumberResult, "The number of results was expected to be \(testNumberResult) after deletion, was \(results.count)")
    }

    func testFetchUserManagedObject() throws {
        let previewContext = PersistenceController.preview.container.viewContext
        let testUserLogin: String = "ezmobius"

        let fetchRequest = UserEntity.fetchRequest()
        fetchRequest.fetchLimit = 1
        fetchRequest.predicate = NSPredicate(format: "login == %@", testUserLogin)

        guard let results = try? previewContext.fetch(fetchRequest),
              let user = results.first else { return }

        XCTAssertEqual(user.login, testUserLogin, "UserLogin should be \(testUserLogin), but it is \(user.login ?? "")")
    }

    func testFetchUserDetailManagedObject() throws {
        let previewContext = PersistenceController.preview.container.viewContext

        let fetchRequest = UserDetailEntity.fetchRequest()
        fetchRequest.fetchLimit = 1
        fetchRequest.predicate = NSPredicate(format: "id == %d", 3)

        guard let results = try? previewContext.fetch(fetchRequest),
              let user = results.first else { return }

        let testUserLogin: String = "mojombo"
        XCTAssertEqual(
            user.login, testUserLogin,
            "UserLogin should be \(testUserLogin), but it is \(user.login ?? "")"
        )
    }
}
