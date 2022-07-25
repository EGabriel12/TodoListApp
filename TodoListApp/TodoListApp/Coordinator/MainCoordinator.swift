//
//  MainCoordinator.swift
//  TodoListApp
//
//  Created by Elias Gabriel on 24/07/22.
//

import UIKit

final class MainCoordinator: Coordinator {
    var navigationController: UINavigationController
    let listManager: ListManager
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.listManager = ListManager()
    }
    
    func start() {
        let rootViewController = ListViewController(listManager: listManager, customView: ListView())
        rootViewController.delegate = self
        navigationController.pushViewController(rootViewController, animated: true)
    }
}

extension MainCoordinator: ListViewControllerDelegate {
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
