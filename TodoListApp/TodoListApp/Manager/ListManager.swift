//
//  ListManager.swift
//  TodoListApp
//
//  Created by Elias Gabriel on 24/07/22.
//

import Foundation
import CoreData

final class ListManager {
    let coreDataManager: CoreDataManager
    
    init(coreDataManager: CoreDataManager = .shared) {
        self.coreDataManager = coreDataManager
    }
    
    func add(_ model: TodoItemModel){
        do {
            let entity = TodoEntity(context: coreDataManager.viewContext())
            entity.title = model.title
            entity.isFavorite = model.isFavorite
            entity.priority = model.priority.rawValue
            entity.dateCreated = model.dateCreated
            try coreDataManager.viewContext().save()
        } catch let error {
            debugPrint("Error into save entity \(error.localizedDescription)")
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
            let model: [TodoItemModel?]  = try coreDataManager.viewContext().fetch(TodoEntity.fetchRequest()).map({ todoEntity in
                if let title = todoEntity.title,
                   let priorityRawValue = todoEntity.priority,
                   let priority = TodoItemPriority(rawValue: priorityRawValue),
                   let dateCreated = todoEntity.dateCreated {
                    return TodoItemModel(priority: priority, title: title, isFavorite: todoEntity.isFavorite, dateCreated: dateCreated)
                }
                return nil
            })
            return model.compactMap({
                $0
            })
            
        } catch let error {
            debugPrint("Error into get all entitys \(error.localizedDescription)")
            return []
        }
    }
    
    func delete(_ model: TodoItemModel) {
        let item = try? coreDataManager.viewContext().fetch(TodoEntity.fetchRequest()).first { todoEntity in
            todoEntity.dateCreated == model.dateCreated
        }
        do {
            if let todoEntity = item {
                coreDataManager.viewContext().delete(todoEntity)
            }
            try coreDataManager.viewContext().save()
        }
        
        catch let error {
            debugPrint("Error into delete entity \(error.localizedDescription)")
        }
    }
    
    func update(_ model: TodoItemModel) {
        let item: TodoEntity? = try? coreDataManager.viewContext().fetch(TodoEntity.fetchRequest()).first {
            todoEntity in
            todoEntity.dateCreated == model.dateCreated
        }
        do {
            if let todoEntity = item {
                todoEntity.title = model.title
                todoEntity.priority = model.priority.rawValue
                todoEntity.isFavorite = model.isFavorite
            }
            try coreDataManager.viewContext().save()
        } catch let error {
            debugPrint("Error into update entity \(error.localizedDescription)")
        }
    }
}
