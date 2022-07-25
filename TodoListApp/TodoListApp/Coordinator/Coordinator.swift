//
//  Coordinator.swift
//  TodoListApp
//
//  Created by Elias Gabriel on 24/07/22.
//

import UIKit

protocol Coordinator {
    var navigationController: UINavigationController { get }
    init(navigationController: UINavigationController)
    func start()
}
