//
//  AddNewTodoViewControllerDelegateSpy.swift
//  TodoListAppTests
//
//  Created by Elias Gabriel on 09/08/22.
//

import Foundation
@testable import TodoListApp

final class AddNewTodoViewControllerDelegateSpy:
    AddNewTodoViewControllerDelegate {
    var popViewControllerWasCalled = false
    
    func popViewController() {
        popViewControllerWasCalled = true
    }
}
