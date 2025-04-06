//
//  ListEntity+CoreDataProperties.swift
//  tasklyst
//
//  Created by Vince Muller on 4/3/25.
//
//

import Foundation
import SwiftUI
import CoreData


extension ListEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ListEntity> {
        return NSFetchRequest<ListEntity>(entityName: "ListEntity")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var dueDate: Date?
    @NSManaged public var items: NSSet?
    @NSManaged public var created: Date?
    
    static func create(in context: NSManagedObjectContext, name: String, dueDate: Date? = nil) {
        let newList = ListEntity(context: context)
        newList.id = UUID()
        newList.name = name
        newList.dueDate = dueDate
        newList.created = Date.now
        
        try? context.save()
    }
    
    var listItemsArray: [ListItemEntity] {
        let set = items as? Set<ListItemEntity> ?? []
        return set.sorted { ($0.created ?? .distantPast) < ($1.created ?? .distantPast) }
    }

}

extension ListEntity : Identifiable {

}
