//
//  CoreDataUtils.swift
//  GithubUsers
//
//  Created by Thong Nguyen on 22/7/24.
//

import CoreData

protocol CoreDataUtils {
    associatedtype ManagedType: NSManagedObject = Self

    //func checkForExistingData(id: Int64, context: NSManagedObjectContext) -> Bool
    func getExistingData(id: Int64, context: NSManagedObjectContext) -> ManagedType?
}

extension CoreDataUtils {
//    func checkForExistingData(id: Int64, context: NSManagedObjectContext) -> Bool {
//        let fetchRequest = ManagedType.fetchRequest()
//        fetchRequest.predicate = NSPredicate(format: "id = %d", id)
//
//        if let results = try? context.fetch(fetchRequest), results.first != nil {
//            return true
//        }
//        return false
//    }

    func getExistingData(id: Int64, context: NSManagedObjectContext) -> ManagedType? {
        let fetchRequest = ManagedType.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id = %d", id)

        if let results = try? context.fetch(fetchRequest), let result = results.first {
            return result as? Self.ManagedType
        }
        return nil
    }
}
