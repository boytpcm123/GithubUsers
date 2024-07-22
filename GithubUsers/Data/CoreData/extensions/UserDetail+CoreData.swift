//
//  User+CoreData.swift
//  GithubUsers
//
//  Created by Thong Nguyen on 21/7/24.
//

import CoreData

extension UserDetail: CoreDataUtils {
    typealias ManagedType = UserDetailEntity

//    init(managedObject: UserDetailEntity) {
//        self.id = managedObject.id
//        self.login = managedObject.login ?? ""
//        self.avatarUrl = managedObject.avatarUrl
//        self.htmlUrl = managedObject.htmlUrl
//        self.location = managedObject.location
//        self.followers = Int(managedObject.followers)
//        self.following = Int(managedObject.following)
//    }

    mutating func toManagedObject(context: NSManagedObjectContext = PersistenceController.shared.container.viewContext) {
        guard checkForExistingData(id: id, context: context) == false else { return }
        
        let persistedValue = UserDetailEntity.init(context: context)
        persistedValue.id = self.id
        persistedValue.login = self.login
        persistedValue.avatarUrl = self.avatarUrl
        persistedValue.htmlUrl = self.htmlUrl
        persistedValue.location = self.location
        persistedValue.followers = Int64(self.followers)
        persistedValue.followersText = self.followersText
        persistedValue.following = Int64(self.following)
        persistedValue.followingText = self.followingText
    }
}
