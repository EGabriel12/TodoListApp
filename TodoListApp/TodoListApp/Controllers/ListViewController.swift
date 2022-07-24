//
//  ListViewController.swift
//  TodoListApp
//
//  Created by Elias Gabriel on 24/07/22.
//

import UIKit

final class ListViewController: UIViewController {
    private let listManager: ListManager
    
    init(listManager: ListManager){
        self.listManager = listManager
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        debugPrint(listManager.getTodoItemsModel())
    }
}
