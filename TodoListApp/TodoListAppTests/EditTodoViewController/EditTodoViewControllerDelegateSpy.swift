//
//  EditTodoViewControllerDelegateSpy.swift
//  TodoListAppTests
//
//  Created by Elias Gabriel on 04/08/22.
//

import Foundation
@testable import TodoListApp

final class EditTodoViewControllerDelegateSpy: EditTodoViewControllerDelegate {
    var popViewControllerWasCalled = false
    
    func popViewController() {
        popViewControllerWasCalled = true
    }
}
