//
//  ListManagerTests.swift
//  TodoListAppTests
//
//  Created by Elias Gabriel on 09/08/22.
//

import Foundation
@testable import TodoListApp
import XCTest

final class ListManagerTests: XCTestCase {
    var sut: ListManagerProtocol!
    var coreDataManagerSpy: CoreDataManagerSpy!
    
    override func setUp() {
        super.setUp()
        coreDataManagerSpy = CoreDataManagerSpy(entityName: "FakeEntity")
        sut = ListManager(coreDataManager: coreDataManagerSpy)
    }
    
    func testLoadPersistentStoresWithSuccess() throws {
        coreDataManagerSpy.loadPersistentStoresStub = true
        
        XCTAssertTrue(coreDataManagerSpy.loadPersistentStores())
        XCTAssertTrue(coreDataManagerSpy.loadPersistentStoresWasCalled)
    }
    
    func testAddNewItem() throws {
        let model = TodoItemModel(
            priority: TodoItemPriority.hard,
            title: "Title",
            isFavorite: true,
            dateCreated: Date()
        )
        
        let flagSave = sut.add(model)
        
        XCTAssertTrue(coreDataManagerSpy.saveWasCalled)
        XCTAssertTrue(flagSave)
        XCTAssertEqual(coreDataManagerSpy.saveStub, model)
    }
    
    func testAddNewItemError() throws {
        let model = TodoItemModel(
            priority: TodoItemPriority.hard,
            title: "Title",
            isFavorite: true,
            dateCreated: Date()
        )
        
        coreDataManagerSpy.hasError = true
        let flagSave = sut.add(model)
        
        XCTAssertFalse(coreDataManagerSpy.saveWasCalled)
        XCTAssertFalse(flagSave)
        XCTAssertNil(coreDataManagerSpy.saveStub)
    }
    
    func testGetAllItemsByPriority() throws {
        let expectedItems = [
            TodoItemModel(
                priority: TodoItemPriority.hard,
                title: "title3",
                isFavorite: true,
                dateCreated: Date()
            ),
            TodoItemModel(
                priority: TodoItemPriority.normal,
                title: "title",
                isFavorite: true,
                dateCreated: Date()
            ),
            TodoItemModel(
                priority: TodoItemPriority.medium,
                title: "title2",
                isFavorite: true,
                dateCreated: Date()
            )
        ]

        coreDataManagerSpy.getAllStub = expectedItems

        let resultItems = sut.getAllItemsByPriority()

        XCTAssertTrue(coreDataManagerSpy.getAllWasCalled)
        XCTAssertEqual(resultItems.count, expectedItems.count)
    }
    
    func testGetAllItemsByPriorityWithError() throws {
        coreDataManagerSpy.hasError = true
        
        let resultItems = sut.getAllItemsByPriority()

        XCTAssertTrue(coreDataManagerSpy.getAllWasCalled)
        XCTAssertNil(coreDataManagerSpy.getAllStub)
        XCTAssertEqual(resultItems.count, 3)
    }
    
    func testDeleteItem() throws {
        let model = TodoItemModel(
            priority: TodoItemPriority.hard,
            title: "Title",
            isFavorite: true,
            dateCreated: Date()
        )
        
        let _ = sut.add(model)
        
        sut.delete(model)
        
        XCTAssertTrue(coreDataManagerSpy.deleteWasCalled)
        XCTAssertEqual(coreDataManagerSpy.deleteStub, model)
    }
    
    func testDeleteItemWithError() throws {
        let model = TodoItemModel(
            priority: TodoItemPriority.hard,
            title: "Title",
            isFavorite: true,
            dateCreated: Date()
        )
        
        let _ = sut.add(model)
        
        coreDataManagerSpy.hasError = true
        
        sut.delete(model)
        
        XCTAssertTrue(coreDataManagerSpy.deleteWasCalled)
        XCTAssertNil(coreDataManagerSpy.deleteStub)
    }
    
    func testUpdateItem() throws {
        let updatedModel = TodoItemModel(
            priority: TodoItemPriority.medium,
            title: "Modified Title",
            isFavorite: false,
            dateCreated: Date.now
        )
                
        sut.update(updatedModel)
                
        XCTAssertTrue(coreDataManagerSpy.updatedWasCalled)
        XCTAssertEqual(coreDataManagerSpy.updateStub, updatedModel)
    }
    
    func testUpdateItemWithError() throws {
        let updatedModel = TodoItemModel(
            priority: TodoItemPriority.medium,
            title: "Modified Title",
            isFavorite: false,
            dateCreated: Date.now
        )
        
        coreDataManagerSpy.hasError = true
                
        sut.update(updatedModel)
                
        XCTAssertTrue(coreDataManagerSpy.updatedWasCalled)
        XCTAssertNil(coreDataManagerSpy.updateStub)
    }
}
