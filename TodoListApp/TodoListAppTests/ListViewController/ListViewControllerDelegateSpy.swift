//
//  ListViewControllerDelegateSpy.swift
//  TodoListAppTests
//
//  Created by Elias Gabriel on 09/08/22.
//

import UIKit
@testable import TodoListApp

final class ListViewControllerDelegateSpy {
    var routerToAddNewTodoViewControllerWasCalled: Bool = false
    var routerToEditTodoViewControllerWasCalled: Bool = false
    var showAlertControllerWasCalled: Bool = false
}

extension ListViewControllerDelegateSpy: ListViewControllerDelegate {
    
    func routerToAddNewTodoViewController() {
        routerToAddNewTodoViewControllerWasCalled = true
    }
    
    func routerToEditTodoViewController(todoItem: TodoItemModel) {
        routerToEditTodoViewControllerWasCalled = true
    }
    
    func showAlertController(title: String, message: String, primaryAction: UIAlertAction) {
        showAlertControllerWasCalled = true
    }
}
