//
//  CoreDataManager.swift
//  TodoListApp
//
//  Created by Elias Gabriel on 24/07/22.
//

import CoreData

protocol CoreDataManagerProtocol {
    var persistentContainer: NSPersistentContainer { get }
    init(entityName: String)
    func save(model: TodoItemModel) throws
    func getAll() throws -> [TodoItemModel]
    func delete(model: TodoItemModel) throws
    func update(model: TodoItemModel) throws
    
    @discardableResult
    func loadPersistentStores() -> Bool
}

final class CoreDataManager: CoreDataManagerProtocol {
    let persistentContainer: NSPersistentContainer
    
    init(entityName: String) {
        persistentContainer = NSPersistentContainer(name: entityName)
    }
    
    @discardableResult
    func loadPersistentStores() -> Bool {
        var hasSuccess = true
        persistentContainer.loadPersistentStores { description, error in
            if let error = error?.localizedDescription {
                debugPrint(error)
                hasSuccess.toggle()
            }
        }
        return hasSuccess
    }
    
    func save(model: TodoItemModel) throws {
        let entity = TodoEntity(context: persistentContainer.viewContext)
        entity.title = model.title
        entity.isFavorite = model.isFavorite
        entity.priority = model.priority.rawValue
        entity.dateCreated = model.dateCreated
        try persistentContainer.viewContext.save()
    }
    
    func getAll() throws -> [TodoItemModel] {
        let model: [TodoItemModel?] = try persistentContainer.viewContext.fetch(TodoEntity.fetchRequest()).map { todoEntity in
            if let title = todoEntity.title,
               let dateCreated = todoEntity.dateCreated,
               let priorityRawValue = todoEntity.priority,
               let priority = TodoItemPriority(rawValue: priorityRawValue) {
                return TodoItemModel(priority: priority, title: title, isFavorite: todoEntity.isFavorite, dateCreated: dateCreated)
               }
            return nil
        }
        return model.compactMap { $0 }
    }
    
    func delete(model: TodoItemModel) throws {
        let context = persistentContainer.viewContext
        let item = try context.fetch(TodoEntity.fetchRequest()).first(where: { todoItem in
            todoItem.dateCreated == model.dateCreated
        })
        
        do {
            if let todoEntity = item {
                context.delete(todoEntity)
            }
            try context.save()
        }
        
        catch let error {
            debugPrint("Error into delete entity \(error.localizedDescription)")
        }
    }
    
    func update(model: TodoItemModel) throws {
        let item = try? persistentContainer.viewContext.fetch(TodoEntity.fetchRequest()).first(where: { todoItem in
            todoItem.dateCreated == model.dateCreated
        })
        
        do {
            if let todoEntity = item {
                todoEntity.title = model.title
                todoEntity.isFavorite = model.isFavorite
                todoEntity.priority = model.priority.rawValue
            }
            try persistentContainer.viewContext.save()
        }
        
        catch let error {
            debugPrint("Error into delete entity \(error.localizedDescription)")
        }
    }
}
