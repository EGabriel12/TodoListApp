//
//  ListViewController.swift
//  TodoListApp
//
//  Created by Elias Gabriel on 24/07/22.
//

import UIKit

protocol ListViewControllerDelegate: AnyObject {
    func routerToAddNewTodoViewController()
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
        addIncludeTodoButtonIntoNavigationItem()
        customView.setup(viewModel: listManager.getAllItemsByPriority())
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        customView.setup(viewModel: listManager.getAllItemsByPriority())
        customView.updatedContentList()
    }
    
    private func addIncludeTodoButtonIntoNavigationItem() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(systemItem: .add, primaryAction: UIAction(handler: { [self] _ in
            delegate?.routerToAddNewTodoViewController()
        }))
    }
}
