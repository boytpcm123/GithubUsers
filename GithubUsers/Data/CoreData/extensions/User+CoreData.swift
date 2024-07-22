//
//  User+CoreData.swift
//  GithubUsers
//
//  Created by Thong Nguyen on 21/7/24.
//

import CoreData

extension User {
    init(managedObject: UserEntity) {
        self.id = managedObject.id
        self.login = managedObject.login ?? ""
        self.avatarUrl = managedObject.avatarUrl
        self.htmlUrl = managedObject.htmlUrl
    }

    mutating func toManagedObject(context: NSManagedObjectContext = PersistenceController.shared.container.viewContext) {
        guard checkForExistingUser(id: id, context: context) == false else { return }
        let persistedValue = UserEntity.init(context: context)
        persistedValue.id = self.id
        persistedValue.login = self.login
        persistedValue.avatarUrl = self.avatarUrl
        persistedValue.htmlUrl = self.htmlUrl
    }

    private func checkForExistingUser(id: Int64, context: NSManagedObjectContext = PersistenceController.shared.container.viewContext) -> Bool {
        let fetchRequest = UserEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id = %d", id)

        if let results = try? context.fetch(fetchRequest), results.first != nil {
            return true
        }
        return false
    }
}
