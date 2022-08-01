//
//  AddNewTodoViewSpy.swift
//  TodoListAppTests
//
//  Created by Elias Gabriel on 31/07/22.
//

@testable import TodoListApp
import UIKit

final class AddNewTodoViewSpy: UIView {
    weak var delegate: AddNewTodoViewDelegate?
}

extension AddNewTodoViewSpy: AddNewTodoViewConfiguration { }
