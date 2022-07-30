//
//  EditTodoViewController.swift
//  TodoListApp
//
//  Created by Elias Gabriel on 27/07/22.
//

import UIKit

protocol EditTodoViewControllerDelegate: AnyObject {
    func popViewController()
}

final class EditTodoViewController: UIViewController {
    weak var delegate: EditTodoViewControllerDelegate?
    private let customView: EditTodoViewConfiguration
    private let listManager: ListManager
    private let todoItem: TodoItemModel
    
    init(listManager: ListManager, customView: EditTodoViewConfiguration, todoItem: TodoItemModel) {
        self.listManager = listManager
        self.customView = customView
        self.todoItem = todoItem
        super.init(nibName: nil, bundle: nil)
    }
    
    override func loadView() {
        super.loadView()
        view = customView
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customView.delegate = self
        customView.setup(viewModel: todoItem)
        view.backgroundColor = .systemBackground
        title = "Edit Item"
    }
    
}

extension EditTodoViewController: EditTodoViewDelegate {
    func didTouchUpSaveButton(item: TodoItemModel) {
        listManager.update(item)
        delegate?.popViewController()
    }
}
