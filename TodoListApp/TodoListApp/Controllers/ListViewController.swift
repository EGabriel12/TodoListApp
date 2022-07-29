//
//  ListViewController.swift
//  TodoListApp
//
//  Created by Elias Gabriel on 24/07/22.
//

import UIKit

protocol ListViewControllerDelegate: AnyObject {
    func routerToAddNewTodoViewController()
    func routerToEditTodoViewController(todoItem: TodoItemModel)
    func showAlertController(title: String, message: String, primaryAction: UIAlertAction)
}

final class ListViewController: UIViewController {
    
    weak var delegate: ListViewControllerDelegate?
    private let customView: ListViewConfiguration
    private let listManager: ListManager
    
    init(listManager: ListManager, customView: ListViewConfiguration){
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
        view.backgroundColor = .systemBackground
        title = "Items"
        customView.delegate = self
        addIncludeTodoButtonIntoNavigationItem()
        customView.setup(viewModel: listManager.getAllItemsByPriority())
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        reloadList()
    }
    
    private func addIncludeTodoButtonIntoNavigationItem() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(systemItem: .add, primaryAction: UIAction(handler: { [self] _ in
            delegate?.routerToAddNewTodoViewController()
        }))
    }
    
    private func reloadList() {
        customView.setup(viewModel: listManager.getAllItemsByPriority())
        customView.updatedContentList()
    }
}

extension ListViewController: ListViewDelegate {
    func didSelectToEditRow(item: TodoItemModel) {
        delegate?.routerToEditTodoViewController(todoItem: item)
    }
    
    func didSwipeToDeleteRow(item: TodoItemModel) {
        delegate?.showAlertController(title: "Do you want to delete this item?", message: "After this operation, the item cannot be recovered", primaryAction: UIAlertAction.init(title: "Confirmar", style: .destructive, handler: { [self] _ in
            listManager.delete(item)
            reloadList()
        }))
        
    }
}
