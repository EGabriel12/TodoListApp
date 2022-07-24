//
//  ListViewController.swift
//  TodoListApp
//
//  Created by Elias Gabriel on 24/07/22.
//

import UIKit

final class ListViewController: UIViewController {
    
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
        
        debugPrint(listManager.getAllItemsByPriority())
        customView.setup(viewModel: listManager.getAllItemsByPriority())
    }
}
