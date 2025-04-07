//
//  Persistence.swift
//  tasklyst
//
//  Created by Vince Muller on 4/3/25.
//

import Foundation
import CoreData


struct PersistenceController {
    static let shared = PersistenceController()

    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "TasklystModel")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Core Data failed: \(error.localizedDescription)")
            }
        }
    }
}
