//
//  ListItemEntity+CoreDataProperties.swift
//  tasklyst
//
//  Created by Vince Muller on 4/3/25.
//
//

import Foundation
import CoreData


extension ListItemEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ListItemEntity> {
        return NSFetchRequest<ListItemEntity>(entityName: "ListItemEntity")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var itemDescription: String?
    @NSManaged public var completed: Bool
    @NSManaged public var created: Date?
    @NSManaged public var list: ListEntity?

    static func create(in context: NSManagedObjectContext, description: String, completed: Bool = false, list: ListEntity) {
        let newItem = ListItemEntity(context: context)
        newItem.id = UUID()
        newItem.itemDescription = description
        newItem.completed = completed
        newItem.list = list
        newItem.created = Date.now
        
        try? context.save()
    }
}

extension ListItemEntity : Identifiable {

}
