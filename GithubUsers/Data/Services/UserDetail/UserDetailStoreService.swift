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
        user.toManagedObject(context: context)
        try context.save()
    }
}
