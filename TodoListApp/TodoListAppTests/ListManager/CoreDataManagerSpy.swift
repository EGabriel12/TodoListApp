//
//  TodoListAppTests.swift
//  TodoListAppTests
//
//  Created by Elias Gabriel on 31/07/22.
//

@testable import TodoListApp

final class ListManagerSpy {
    let coreDataManager: CoreDataManager = .shared
    var addWasCalled: Bool = false
    var deleteWasCalled: Bool = false
    var updateWasCalled: Bool = false
    var getAllItemsByPriorityWasCalled: Bool = false
}

extension ListManagerSpy: ListManagerProtocol {
    func add(_ model: TodoItemModel) {
        addWasCalled = true
    }
    
    func delete(_ model: TodoItemModel) {
        deleteWasCalled = true
    }
    
    func update(_ model: TodoItemModel) {
        updateWasCalled = true
    }
    
    func getAllItemsByPriority() -> [[TodoItemModel]] {
        getAllItemsByPriorityWasCalled = true
        return [[]]
    }
    
    
}
