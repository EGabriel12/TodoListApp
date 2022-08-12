//
//  TodoListAppTests.swift
//  TodoListAppTests
//
//  Created by Elias Gabriel on 31/07/22.
//

@testable import TodoListApp

final class ListManagerSpy {
    let coreDataManager: CoreDataManagerProtocol = CoreDataManager(entityName: "")
    var addWasCalled: Bool = false
    var addStub: Bool = false
    var deleteWasCalled: Bool = false
    var updateWasCalled: Bool = false
    var getAllItemsByPriorityWasCalled: Bool = false
}

extension ListManagerSpy: ListManagerProtocol {
    func add(_ model: TodoItemModel) -> Bool {
        addWasCalled = true
        return addStub
    }
    
    func delete(_ model: TodoItemModel) {
        deleteWasCalled = true
    }
    
    func update(_ model: TodoItemModel) {
        updateWasCalled = true
    }
    
    func getAllItemsByPriority() -> [[TodoItemModel]] {
        getAllItemsByPriorityWasCalled = true
        return [getAllItems()]
    }
    
    func getAllItems() -> [TodoItemModel] {
        do {
            return try coreDataManager.getAll()
        } catch let error {
            debugPrint("Error into get all entitys \(error.localizedDescription)")
            return []
        }
    }
}
