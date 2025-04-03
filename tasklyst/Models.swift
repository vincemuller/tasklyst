//
//  Models.swift
//  tasklyst
//
//  Created by Vince Muller on 3/31/25.
//

import Foundation


struct Lists: Identifiable {
    var id = UUID()
    var name: String
    var listItems: [ListItem]
    var dueDate: Date?
    
    func getMockData() -> [ListItem] {
        return [ListItem(listDescription: "Whole milk", completed: false),
                ListItem(listDescription: "Loaf of bread", completed: false),
                ListItem(listDescription: "Yogurt", completed: false),
                ListItem(listDescription: "Breakfast sausage", completed: false),
                ListItem(listDescription: "Raspberries", completed: false),
                ListItem(listDescription: "Strawberries", completed: false),
                ListItem(listDescription: "Blueberries", completed: false)]
    }
    
}

struct ListItem: Identifiable {
    var id = UUID()
    var listDescription: String
    var completed: Bool
}
