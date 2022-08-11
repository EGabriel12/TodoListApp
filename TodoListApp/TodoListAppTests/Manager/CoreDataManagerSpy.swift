//
//  TodoListAppTests.swift
//  TodoListAppTests
//
//  Created by Elias Gabriel on 31/07/22.
//

@testable import TodoListApp
import CoreData

final class CoreDataManagerSpy {
    let coreDataManager: CoreDataManagerProtocol = CoreDataManager(entityName: "")
    var loadPersistentStoresStub: Bool = false
    var saveStub: TodoItemModel?
    var hasError: Bool = false
    var deleteStub: TodoItemModel?
    var updateStub: TodoItemModel?
    var getAllStub: [TodoItemModel] = []
    var getAllItemsByPriorityWasCalled: Bool = false
    
    var loadPersistentStoresWasCalled: Bool = false
    var saveWasCalled: Bool = false
    var deleteWasCalled: Bool = false
    var updatedWasCalled: Bool = false
    var getAllWasCalled: Bool = false
    
    let persistentContainer: NSPersistentContainer
    
    init(entityName: String) {
        self.persistentContainer = NSPersistentContainer(name: entityName)
    }
}

extension CoreDataManagerSpy: CoreDataManagerProtocol {
    func delete(model: TodoItemModel) throws {
        deleteWasCalled = true
        deleteStub = model
    }
    
    func update(model: TodoItemModel) throws {
        updatedWasCalled = true
        updateStub = model
    }
    
    func save(model: TodoItemModel) throws {
        if hasError {
            throw NSError(domain: "domain", code: -1200)
        }
        else {
            saveWasCalled = true
            saveStub = model
        }
    }
    
    func getAll() throws -> [TodoItemModel] {
        getAllWasCalled = true
        return getAllStub
        
    }
    
    func loadPersistentStores() -> Bool {
        loadPersistentStoresWasCalled  = true
        return loadPersistentStoresStub
    }
}
