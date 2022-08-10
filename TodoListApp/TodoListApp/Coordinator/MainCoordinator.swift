//
//  MainCoordinator.swift
//  TodoListApp
//
//  Created by Elias Gabriel on 24/07/22.
//

import UIKit

final class MainCoordinator: Coordinator {
    var navigationController: UINavigationController
    let listManager: ListManagerProtocol
    let coreDataManager: CoreDataManagerProtocol
    
    init(navigationController: UINavigationController) {
        self.coreDataManager = CoreDataManager(entityName: "TodoModel")
        self.navigationController = navigationController
        self.listManager = ListManager(coreDataManager: coreDataManager)
    }
    
    func start() {
        coreDataManager.loadPersistentStores()
        
        let rootViewController = ListViewController(listManager: listManager, customView: ListView())
        rootViewController.delegate = self
        navigationController.pushViewController(rootViewController, animated: true)
    }
    
    private func presentAlertController(title: String, message: String, primaryAction: UIAlertAction) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        alertController.addAction(primaryAction)
        alertController.addAction(UIAlertAction.init(title: "Cancel", style: .cancel))
        navigationController.topViewController?.present(alertController, animated: true)
    }
}

extension MainCoordinator: ListViewControllerDelegate {
    func routerToEditTodoViewController(todoItem: TodoItemModel) {
        let viewController = EditTodoViewController(listManager: listManager, customView: EditTodoView(), todoItem: todoItem)
        viewController.delegate = self
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func showAlertController(title: String, message: String, primaryAction: UIAlertAction) {
        presentAlertController(title: title, message: message, primaryAction: primaryAction)
    }
    
    func routerToAddNewTodoViewController() {
        let viewController = AddNewTodoViewController(listManager: listManager, customView: AddNewTodoView())
        viewController.delegate = self
        navigationController.pushViewController(viewController, animated: true)
    }
}

extension MainCoordinator: AddNewTodoViewControllerDelegate {
    func popViewController() {
        navigationController.popViewController(animated: true)
    }
}

extension MainCoordinator: EditTodoViewControllerDelegate {}
