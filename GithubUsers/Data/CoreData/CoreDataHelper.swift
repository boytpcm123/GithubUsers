//
//  CoreDataHelper.swift
//  GithubUsers
//
//  Created by Thong Nguyen on 22/7/24.
//

import CoreData

@MainActor
enum CoreDataHelper {
    static let context = PersistenceController.shared.container.viewContext
    static let previewContext = PersistenceController.preview.container.viewContext

    static func clearDatabase() {
        let entities = PersistenceController.shared.container.managedObjectModel.entities
        entities.compactMap(\.name).forEach(CoreDataHelper.clearTable)
    }

    private static func clearTable(_ entity: String) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        do {
            try context.execute(deleteRequest)
            try context.save()
        } catch {
            fatalError("\(#file), \(#function), \(error.localizedDescription)")
        }
    }
}

// MARK: - Deleting Data
extension Collection where Element == NSManagedObject, Index == Int {
  func delete(at indices: IndexSet, inViewContext viewContext: NSManagedObjectContext) {
    indices.forEach { index in
      viewContext.delete(self[index])
    }

    do {
      try viewContext.save()
    } catch {
      fatalError("""
        \(#file), \
        \(#function), \
        \(error.localizedDescription)
      """)
    }
  }
}

// MARK: - Xcode Previews Content
extension CoreDataHelper {
    static func getTestUserEntities() -> [UserEntity] {
        let fetchRequest = UserEntity.fetchRequest()
        guard let results = try? previewContext.fetch(fetchRequest),
              !results.isEmpty else { return [] }
        return results
    }

    static func getTestUserEntity() -> UserEntity? {
        let fetchRequest = UserEntity.fetchRequest()
        fetchRequest.fetchLimit = 1
        guard let results = try? previewContext.fetch(fetchRequest),
              let first = results.first else { return nil }
        return first
    }
}
