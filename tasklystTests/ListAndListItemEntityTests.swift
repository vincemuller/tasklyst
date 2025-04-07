//
//  ListEntityTests.swift
//  tasklystTests
//
//  Created by Vince Muller on 4/6/25.
//

import XCTest
import CoreData
@testable import tasklyst


final class ListEntityTests: XCTestCase {
    
    
    var context: NSManagedObjectContext!

    // MARK: - Setup & Teardown

    override func setUpWithError() throws {
        let persistence = PersistenceController(inMemory: true)
        context = persistence.container.viewContext
    }

    override func tearDownWithError() throws {
        context = nil
    }

    // MARK: - Helpers

    private func fetchLists() throws -> [ListEntity] {
        try context.fetch(ListEntity.fetchRequest())
    }

    private func fetchListItems() throws -> [ListItemEntity] {
        try context.fetch(ListItemEntity.fetchRequest())
    }

    // MARK: - Tests

    func testCreateListEntity() throws {
        // When
        ListEntity.create(in: context, name: "Test List", dueDate: nil)

        // Then
        let results = try fetchLists()

        XCTAssertEqual(results.count, 1)
        let list = results.first!
        XCTAssertEqual(list.name, "Test List")
        XCTAssertNotNil(list.id)
        XCTAssertNotNil(list.created)
        XCTAssertNil(list.dueDate)
    }
    
    func testDeleteListEntity() throws {
        // Given
        ListEntity.create(in: context, name: "To Delete")
        let list = try fetchLists().first!
        
        // When
        context.delete(list)
        try context.save()
        
        // Then
        let resultsAfterDelete = try fetchLists()
        XCTAssertEqual(resultsAfterDelete.count, 0)
    }
    
    func testCreateListItemEntity() throws {
        // Given
        ListEntity.create(in: context, name: "Grocery List")
        let list = try fetchLists().first!
        
        // When
        ListItemEntity.create(in: context, description: "apple cider vinegar", completed: false, list: list)
        
        // Then
        let items = try fetchListItems()
        let item = items.first!
        XCTAssertEqual(items.count, 1)
        XCTAssertEqual(item.itemDescription, "apple cider vinegar")
        XCTAssertEqual(item.list?.name, "Grocery List")
        XCTAssertFalse(item.completed)
    }

    func testDeleteListItemEntity() throws {
        // Given
        ListEntity.create(in: context, name: "With Item")
        let list = try fetchLists().first!
        ListItemEntity.create(in: context, description: "Delete me", completed: false, list: list)
        
        let item = try fetchListItems().first!
        XCTAssertEqual(try fetchListItems().count, 1)
        
        // When
        context.delete(item)
        try context.save()
        
        // Then
        XCTAssertEqual(try fetchListItems().count, 0)
    }
    
    func testUpdateListEntityName() throws {
        // Given
        ListEntity.create(in: context, name: "Old Name")
        let list = try fetchLists().first!
        
        // When
        list.name = "Updated Name"
        try context.save()
        
        // Then
        let updatedList = try fetchLists().first!
        XCTAssertEqual(updatedList.name, "Updated Name")
    }

    func testUpdateListItemEntityCompletionStatus() throws {
        // Given
        ListEntity.create(in: context, name: "List")
        let list = try fetchLists().first!
        ListItemEntity.create(in: context, description: "Buy eggs", completed: false, list: list)
        let item = try fetchListItems().first!
        
        // When
        item.completed = true
        try context.save()
        
        // Then
        let updatedItem = try fetchListItems().first!
        XCTAssertTrue(updatedItem.completed)
    }

}
