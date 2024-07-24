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
        try await withCheckedThrowingContinuation { continuation in
            context.perform {
                do {
                    for var user in users {
                        user.toManagedObject(context: self.context)
                    }
                    try self.context.save()
                    continuation.resume()
                } catch {
                    continuation.resume(throwing: error)
                }
            }
        }
    }
}
