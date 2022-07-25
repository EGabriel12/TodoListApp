//
//  AddNewTodoViewController.swift
//  TodoListApp
//
//  Created by Elias Gabriel on 24/07/22.
//

import UIKit

final class AddNewTodoViewController: UIViewController {
    private let customView: AddNewTodoViewConfiguration
    private let listManager: ListManager
    
    init(listManager: ListManager, customView: AddNewTodoViewConfiguration){
        self.listManager = listManager
        self.customView = customView
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        view = customView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Add Item"
        view.backgroundColor = .systemBackground
        customView.delegate = self
    }
}

extension AddNewTodoViewController: AddNewTodoViewDelegate {
    func didTouchUpSaveButton(item: TodoItemModel) {
        listManager.add(item)
        navigationController?.popViewController(animated: true)
    }
}