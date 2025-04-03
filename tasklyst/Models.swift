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
        return [ListItem(itemDescription: "Whole milk", completed: false),
                ListItem(itemDescription: "Loaf of bread", completed: false),
                ListItem(itemDescription: "Yogurt", completed: false),
                ListItem(itemDescription: "Breakfast sausage", completed: false),
                ListItem(itemDescription: "Raspberries", completed: false),
                ListItem(itemDescription: "Strawberries", completed: false),
                ListItem(itemDescription: "Blueberries", completed: false)]
    }
    
}

struct ListItem: Identifiable {
    var id = UUID()
    var itemDescription: String
    var completed: Bool
}
