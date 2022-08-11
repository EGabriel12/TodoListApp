//
//  ListManager.swift
//  TodoListApp
//
//  Created by Elias Gabriel on 24/07/22.
//

import Foundation
import CoreData

protocol ListManagerProtocol {
    var coreDataManager: CoreDataManagerProtocol { get }
    func delete(_ model: TodoItemModel)
    func update(_ model: TodoItemModel)
    
    @discardableResult
    func add(_ model: TodoItemModel) -> Bool
    func getAllItemsByPriority() -> [[TodoItemModel]]
}

final class ListManager: ListManagerProtocol {
    let coreDataManager: CoreDataManagerProtocol
    
    init(coreDataManager: CoreDataManagerProtocol) {
        self.coreDataManager = coreDataManager
    }
    
    func add(_ model: TodoItemModel) -> Bool {
        do {
            try coreDataManager.save(model: model)
            return true
        } catch let error {
            debugPrint("Error into save entity \(error.localizedDescription)")
            return false
        }
    }
    
    func getAllItemsByPriority() -> [[TodoItemModel]] {
        TodoItemPriority.allCases.map { priority in
            getAllItems().filter { model in
                model.priority == priority
            }
        }
    }
    
    func getAllItems() -> [TodoItemModel] {
        do {
            return try coreDataManager.getAll()
        } catch let error {
            debugPrint("Error into get all entitys \(error.localizedDescription)")
            return []
        }
    }
    
    func delete(_ model: TodoItemModel) {
        do {
            try coreDataManager.delete(model: model)
        }
        catch let error {
            debugPrint("Error into delete entity \(error.localizedDescription)")
        }
    }
    
    func update(_ model: TodoItemModel) {
        do {
            try coreDataManager.update(model: model)
        } catch let error {
            debugPrint("Error into update entity \(error.localizedDescription)")
        }
    }
}
