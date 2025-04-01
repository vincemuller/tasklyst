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
        return [ListItem(description: "Whole milk", completed: false),
                ListItem(description: "Loaf of bread", completed: false),
                ListItem(description: "Yogurt", completed: false),
                ListItem(description: "Breakfast sausage", completed: false),
                ListItem(description: "Raspberries", completed: false),
                ListItem(description: "Strawberries", completed: false),
                ListItem(description: "Blueberries", completed: false)]
    }
    
}

struct ListItem: Identifiable {
    var id = UUID()
    var description: String
    var completed: Bool
}
