//
//  User+CoreData.swift
//  GithubUsers
//
//  Created by Thong Nguyen on 21/7/24.
//

import CoreData

extension UserDetail {
    init(managedObject: UserDetailEntity) {
        self.id = managedObject.id
        self.login = managedObject.login ?? ""
        self.avatarUrl = managedObject.avatarUrl
        self.htmlUrl = managedObject.htmlUrl
        self.location = managedObject.location
        self.followers = Int(managedObject.followers)
        self.following = Int(managedObject.following)
    }

    mutating func toManagedObject(context: NSManagedObjectContext = PersistenceController.shared.container.viewContext) {
        guard checkForExistingUser(id: id, context: context) == false else { return }
        let persistedValue = UserDetailEntity.init(context: context)
        persistedValue.id = self.id
        persistedValue.login = self.login
        persistedValue.avatarUrl = self.avatarUrl
        persistedValue.htmlUrl = self.htmlUrl
        persistedValue.location = self.location
        persistedValue.followers = Int64(self.followers)
        persistedValue.following = Int64(self.following)
    }

    private func checkForExistingUser(id: Int64, context: NSManagedObjectContext = PersistenceController.shared.container.viewContext) -> Bool {
        let fetchRequest = UserDetailEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id = %d", id)

        if let results = try? context.fetch(fetchRequest), results.first != nil {
            return true
        }
        return false
    }
}
