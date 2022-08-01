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
    
    override func setUp() {
        super.setUp()
        listManagerSpy = ListManagerSpy()
        addNewTodoViewSpy = AddNewTodoViewSpy()
        sut = AddNewTodoViewController(listManager: listManagerSpy, customView: addNewTodoViewSpy)
    }
    
    func testViewDidLoad() {
        sut.loadViewIfNeeded()
        
        XCTAssertEqual(sut.title, "Add Item")
        XCTAssertEqual(sut.view.backgroundColor, .systemBackground)
    }
}
