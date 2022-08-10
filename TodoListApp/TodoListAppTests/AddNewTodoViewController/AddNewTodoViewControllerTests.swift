//
//  AddNewTodoViewController.swift
//  TodoListAppTests
//
//  Created by Elias Gabriel on 31/07/22.
//

@testable import TodoListApp
import XCTest

final class AddNewTodoViewControllerTests: XCTestCase {
    var sut: AddNewTodoViewController!
    var listManagerSpy: ListManagerSpy!
    var addNewTodoViewSpy: AddNewTodoViewSpy!
    var addNewTodoViewControllerDelegateSpy: AddNewTodoViewControllerDelegateSpy!
    
    override func setUp() {
        super.setUp()
        listManagerSpy = ListManagerSpy()
        addNewTodoViewSpy = AddNewTodoViewSpy()
        addNewTodoViewControllerDelegateSpy = AddNewTodoViewControllerDelegateSpy()
        sut = AddNewTodoViewController(listManager: listManagerSpy, customView: addNewTodoViewSpy)
        sut.delegate = addNewTodoViewControllerDelegateSpy
    }
    
    func testViewDidLoad() {
        sut.loadViewIfNeeded()
        
        XCTAssertEqual(sut.title, "Add Item")
        XCTAssertEqual(sut.view.backgroundColor, .systemBackground)
    }
    
    func testDidTouchUpSaveButton() {
        sut.didTouchUpSaveButton(item: TodoItemModel(priority: TodoItemPriority.medium, title: "Test 1", isFavorite: false, dateCreated: Date.now))
        
        XCTAssertTrue(listManagerSpy.addWasCalled)
        XCTAssertTrue(addNewTodoViewControllerDelegateSpy.popViewControllerWasCalled)
    }
}
