//
//  tasklystApp.swift
//  tasklyst
//
//  Created by Vince Muller on 3/31/25.
//

import SwiftUI

@main
struct tasklystApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
