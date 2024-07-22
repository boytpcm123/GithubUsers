//
//  User+CoreData.swift
//  GithubUsers
//
//  Created by Thong Nguyen on 21/7/24.
//

import CoreData

// extension User: CoreDataPersistable {
////    init() {
////        self.id = nil
////        self.login = ""
////        self.avatarUrl = ""
////        self.htmlUrl = ""
////    }
//
//    var keyMap: [PartialKeyPath<User>: String] {
//        [
//            \.id: "id",
//             \.login: "login",
//             \.avatarUrl: "avatarUrl",
//             \.htmlUrl: "htmlUrl"
//        ]
//    }
//
//    typealias ManagedType = UserEntity
// }
//
// extension UserDetail: CoreDataPersistable {
////    init() {
////        self.id = nil
////        self.login = ""
////        self.avatarUrl = ""
////        self.htmlUrl = ""
////        self.location = ""
////        self.followers = 0
////        self.following = 0
////    }
//
//    var keyMap: [PartialKeyPath<UserDetail>: String] {
//        [
//            \.id: "id",
//             \.login: "login",
//             \.avatarUrl: "avatarUrl",
//             \.htmlUrl: "htmlUrl",
//             \.location: "location",
//             \.followers: "followers",
//             \.following: "following"
//        ]
//    }
//
//    typealias ManagedType = UserDetailEntity
// }

extension User {
    init(managedObject: UserEntity) {
        self.id = managedObject.id
        self.login = managedObject.login ?? ""
        self.avatarUrl = managedObject.avatarUrl ?? ""
        self.htmlUrl = managedObject.htmlUrl ?? ""
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
