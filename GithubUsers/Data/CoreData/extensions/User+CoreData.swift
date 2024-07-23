//
//  User+CoreData.swift
//  GithubUsers
//
//  Created by Thong Nguyen on 21/7/24.
//

import CoreData

extension User: CoreDataUtils {
    typealias ManagedType = UserEntity

//    init(managedObject: UserEntity) {
//        self.id = managedObject.id
//        self.login = managedObject.login ?? ""
//        self.avatarUrl = managedObject.avatarUrl
//        self.htmlUrl = managedObject.htmlUrl
//    }

    mutating func toManagedObject(context: NSManagedObjectContext = PersistenceController.shared.container.viewContext) {

        var persistedValue: ManagedType
        if let result = getExistingData(id: id, context: context) {
            persistedValue = result
        } else {
            persistedValue = ManagedType.init(context: context)
            persistedValue.id = self.id
        }

        persistedValue.login = self.login
        persistedValue.avatarUrl = self.avatarUrl
        persistedValue.htmlUrl = self.htmlUrl
    }
}
