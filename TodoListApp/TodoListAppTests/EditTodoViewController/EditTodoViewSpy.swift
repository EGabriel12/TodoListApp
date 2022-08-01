//
//  EditTodoViewSpy.swift
//  TodoListAppTests
//
//  Created by Elias Gabriel on 31/07/22.
//

@testable import TodoListApp
import UIKit

final class EditTodoViewSpy: UIView {
    weak var delegate: EditTodoViewDelegate?
    var setupWasCalled: Bool = false
    let todoItem: TodoItemModel? = TodoItemModel(priority: TodoItemPriority.medium, title: "Bring the drinks", isFavorite: true, dateCreated: Date.now)
}

extension EditTodoViewSpy: EditTodoViewConfiguration {
    func setup(viewModel: TodoItemModel) {
        setupWasCalled = true
    }
}
