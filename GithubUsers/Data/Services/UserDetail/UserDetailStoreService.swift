//
//  UserDetailStoreService.swift
//  GithubUsers
//
//  Created by Thong Nguyen on 22/7/24.
//

import Foundation
import CoreData

actor UserDetailStoreService {
    private let context: NSManagedObjectContext

    init(context: NSManagedObjectContext = PersistenceController.shared.container.newBackgroundContext()) {
        self.context = context
    }
}

// MARK: - UserDetailStore
extension UserDetailStoreService: UserDetailStore {
    func save(user: UserDetail?) async throws {
        guard var user else { return }
        try await withCheckedThrowingContinuation { continuation in
            context.perform {
                do {
                    user.toManagedObject(context: self.context)
                    try self.context.save()
                    continuation.resume()
                } catch {
                    continuation.resume(throwing: error)
                }
            }
        }
    }
}
