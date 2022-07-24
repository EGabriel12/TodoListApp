//
//  TodoItemModel.swift
//  TodoListApp
//
//  Created by Elias Gabriel on 24/07/22.
//

import Foundation
import UIKit


struct TodoItemModel {
    let priority: TodoItemPriority
    let title: String
    let isFavorite: Bool
    let dateCreated: Date
}

enum TodoItemPriority: String, CaseIterable {
    case normal
    case medium
    case hard
    
    var title: String {
        rawValue.capitalized
    }
    
    var color: UIColor {
        switch self {
        case .normal:
            return .green
        case .medium:
            return .orange
        case .hard:
            return .red
        }
    }
    
}
