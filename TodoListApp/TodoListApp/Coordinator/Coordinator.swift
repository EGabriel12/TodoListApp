//
//  Coordinator.swift
//  TodoListApp
//
//  Created by Elias Gabriel on 24/07/22.
//

import UIKit

protocol Coordinator {
    var navigationController: UINavigationController { get }
    var listManager: ListManagerProtocol { get }
    var coreDataManager: CoreDataManagerProtocol { get }
    init(navigationController: UINavigationController, coreDataManager: CoreDataManagerProtocol)
    func start()
}
