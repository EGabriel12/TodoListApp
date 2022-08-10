//
//  EditTodoViewControllerTests.swift
//  TodoListAppTests
//
//  Created by Elias Gabriel on 31/07/22.
//

@testable import TodoListApp
import XCTest

final class EditTodoViewControllerTests: XCTestCase {
    var sut: EditTodoViewController!
    var listManagerSpy: ListManagerSpy!
    var editTodoViewSpy: EditTodoViewSpy!
    var editTodoViewControllerDelegateSpy: EditTodoViewControllerDelegateSpy!
    
    override func setUp() {
        super.setUp()
        listManagerSpy = ListManagerSpy()
        editTodoViewSpy = EditTodoViewSpy()
        editTodoViewControllerDelegateSpy = EditTodoViewControllerDelegateSpy()
        sut = EditTodoViewController(listManager: listManagerSpy, customView: editTodoViewSpy, todoItem: editTodoViewSpy.todoItem!)
        sut.delegate = editTodoViewControllerDelegateSpy
    }
    
    func testViewDidLoad() {
        sut.loadViewIfNeeded()
        
        XCTAssertEqual(sut.title, "Edit Item")
        XCTAssertEqual(sut.view.backgroundColor, .systemBackground)
        XCTAssert(editTodoViewSpy.setupWasCalled)
    }
    
    func testDidTouchUpSaveButton() {
        sut.didTouchUpSaveButton(item: TodoItemModel(priority: TodoItemPriority.medium, title: "Test 1", isFavorite: false, dateCreated: Date.now))
        
        XCTAssertTrue(listManagerSpy.updateWasCalled)
        XCTAssertTrue(editTodoViewControllerDelegateSpy.popViewControllerWasCalled)
    }
}
