//
//  Models.swift
//  tasklyst
//
//  Created by Vince Muller on 3/31/25.
//

import Foundation


struct ListModel: Identifiable {
    var id = UUID()
    var name: String
    var listItems: [ListItemModel]
    var dueDate: Date?
    
    func getMockData() -> [ListItemModel] {
        return [ListItemModel(itemDescription: "Whole milk", completed: false),
                ListItemModel(itemDescription: "Loaf of bread", completed: false),
                ListItemModel(itemDescription: "Yogurt", completed: false),
                ListItemModel(itemDescription: "Breakfast sausage", completed: false),
                ListItemModel(itemDescription: "Raspberries", completed: false),
                ListItemModel(itemDescription: "Strawberries", completed: false),
                ListItemModel(itemDescription: "Blueberries", completed: false)]
    }
    
}

struct ListItemModel: Identifiable {
    var id = UUID()
    var itemDescription: String
    var completed: Bool
}
