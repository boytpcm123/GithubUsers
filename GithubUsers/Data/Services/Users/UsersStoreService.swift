//
//  UsersStoreService.swift
//  GithubUsers
//
//  Created by Thong Nguyen on 22/7/24.
//

import Foundation
import CoreData

actor UsersStoreService {
    private let context: NSManagedObjectContext

    init(context: NSManagedObjectContext = PersistenceController.shared.container.newBackgroundContext()) {
        self.context = context
    }
}

// MARK: - UsersStore
extension UsersStoreService: UsersStore {
    func save(users: [User]) async throws {
        for var user in users {
            user.toManagedObject(context: context)
        }
        try context.save()
    }
}
