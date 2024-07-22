//
//  CoreDataPersistable.swift
//  GithubUsers
//
//  Created by Thong Nguyen on 21/7/24.
//

import CoreData

protocol UUIDIdentifiable: Identifiable {
    var id: Int64 { get set }
}

protocol CoreDataPersistable: UUIDIdentifiable {
    // bind a value type, struct, with a class type, ManagedType
    associatedtype ManagedType

    // initializer sets up the object’s basic state
    init()

    //  initializer takes in the ManagedType object as a parameter.
    //  The initializer’s body will handle the conversion from class to struct.
    init(managedObject: ManagedType?)

    // map key to set values from the managed object to the struct
    var keyMap: [PartialKeyPath<Self>: String] { get }

    // saves the struct-based object to the Core Data store.
    mutating func toManagedObject(context: NSManagedObjectContext) -> ManagedType

    // saves the view context to disk, persisting the data.
    func save(context: NSManagedObjectContext) throws
}

// MARK: - Managed Object
extension CoreDataPersistable where ManagedType: NSManagedObject {
    init(managedObject: ManagedType?) {
        self.init()
        guard let managedObject = managedObject else { return }
        for attribute in managedObject.entity.attributesByName {  // this gets attributes, not relationships
            if let keyP = keyMap.first(where: { $0.value == attribute.key })?.key {
                let value = managedObject.value(forKey: attribute.key)
                storeValue(value, toKeyPath: keyP)
            }
        }
    }

    private mutating func storeValue(_ value: Any?, toKeyPath partial: AnyKeyPath) {
        switch partial {
        case let keyPath as WritableKeyPath<Self, URL?>:
            self[keyPath: keyPath] = value as? URL
        case let keyPath as WritableKeyPath<Self, Int?>:
            self[keyPath: keyPath] = value as? Int
        case let keyPath as WritableKeyPath<Self, String?>:
            self[keyPath: keyPath] = value as? String
        case let keyPath as WritableKeyPath<Self, Bool?>:
            self[keyPath: keyPath] = value as? Bool

        default:
            return
        }
    }

    mutating func toManagedObject(context: NSManagedObjectContext = PersistenceController.shared.container.viewContext) -> ManagedType {
        let persistedValue: ManagedType
        let fetchRequest = ManagedType.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id = %@", id as CVarArg)
        if let results = try? context.fetch(fetchRequest),
           let firstResult = results.first as? ManagedType {
            persistedValue = firstResult
        } else {
            persistedValue = ManagedType.init(context: context)
            self.id = persistedValue.value(forKey: "id") as? Int64 ?? -1
        }

        return setValuesFromMirror(persistedValue: persistedValue)
    }

    private func setValuesFromMirror(persistedValue: ManagedType) -> ManagedType {
        let mirror = Mirror(reflecting: self)
        for case let (label?, value) in mirror.children {
            let value2 = Mirror(reflecting: value)
            if value2.displayStyle != .optional || !value2.children.isEmpty {
                persistedValue.setValue(value, forKey: label)
            }
        }

        return persistedValue
    }

    func save(context: NSManagedObjectContext = PersistenceController.shared.container.viewContext) throws {
        try context.save()
    }
}
