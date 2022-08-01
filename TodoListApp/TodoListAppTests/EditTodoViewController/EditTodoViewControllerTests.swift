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
    
    override func setUp() {
        super.setUp()
        listManagerSpy = ListManagerSpy()
        editTodoViewSpy = EditTodoViewSpy()
        sut = EditTodoViewController(listManager: listManagerSpy, customView: editTodoViewSpy, todoItem: editTodoViewSpy.todoItem!)
    }
    
    func testViewDidLoad() {
        sut.loadViewIfNeeded()
        XCTAssertEqual(sut.title, "Edit Item")
        XCTAssertEqual(sut.view.backgroundColor, .systemBackground)
        XCTAssert(editTodoViewSpy.setupWasCalled)
    }
}
