//
//  CoreDataUtils.swift
//  GithubUsers
//
//  Created by Thong Nguyen on 22/7/24.
//

import CoreData

protocol CoreDataUtils {
    associatedtype ManagedType 

    func checkForExistingData(id: Int64, context: NSManagedObjectContext) -> Bool
}

extension CoreDataUtils where ManagedType: NSManagedObject {
    func checkForExistingData(id: Int64, context: NSManagedObjectContext) -> Bool {
        let fetchRequest = ManagedType.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id = %d", id)

        if let results = try? context.fetch(fetchRequest), results.first != nil {
            return true
        }
        return false
    }
}
