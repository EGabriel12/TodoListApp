//
//  CoreDataManager.swift
//  TodoListApp
//
//  Created by Elias Gabriel on 24/07/22.
//

import CoreData

final class CoreDataManager {
    let persistentContainer: NSPersistentContainer
    static let shared: CoreDataManager = CoreDataManager()
    
    private init() {
        persistentContainer = NSPersistentContainer(name: "TodoModel")
        persistentContainer.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Unable to inializer CoreData \(error)")
            }
        }
    }
    
    func viewContext() -> NSManagedObjectContext {
        persistentContainer.viewContext
    }
}
