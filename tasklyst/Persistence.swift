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

    init() {
        container = NSPersistentContainer(name: "TasklystModel")
        container.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Core Data failed: \(error.localizedDescription)")
            }
        }
    }
}
