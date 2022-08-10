//
//  ListViewControllerTests.swift
//  TodoListAppTests
//
//  Created by Elias Gabriel on 31/07/22.
//

@testable import TodoListApp
import XCTest

final class LisViewControllerTests: XCTestCase {
    var sut: ListViewController!
    var listManagerSpy: ListManagerSpy!
    var listViewSpy: ListViewSpy!
    var listViewControllerDelegateSpy: ListViewControllerDelegateSpy!
    
    override func setUp() {
        super.setUp()
        listManagerSpy = ListManagerSpy()
        listViewSpy = ListViewSpy()
        listViewControllerDelegateSpy = ListViewControllerDelegateSpy()
        sut = ListViewController(listManager: listManagerSpy, customView: listViewSpy)
        sut.delegate = listViewControllerDelegateSpy
    }
    
    func testViewDidLoad() {
        sut.loadViewIfNeeded()
        
        XCTAssertEqual(sut.title, "Items")
        XCTAssertEqual(sut.view.backgroundColor, UIColor.systemBackground)
        XCTAssertTrue(listViewSpy.setupWasCalled)
        XCTAssertTrue(listManagerSpy.getAllItemsByPriorityWasCalled)
        XCTAssertNotNil(sut.navigationItem.rightBarButtonItem)
    }
    
    func testViewDidAppear() {
        sut.viewDidAppear(true)
        
        XCTAssert(listViewSpy.setupWasCalled)
        XCTAssert(listManagerSpy.getAllItemsByPriorityWasCalled)
        XCTAssert(listViewSpy.updatedContentListWasCalled)
    }
    
    func testDidSelectToEditRow() {
        sut.didSelectToEditRow(item: TodoItemModel(priority: TodoItemPriority.medium, title: "Test 1", isFavorite: false, dateCreated: Date.now))
        
        XCTAssertTrue(listViewControllerDelegateSpy.routerToEditTodoViewControllerWasCalled)
    }
    
    func testDidSwipeToDeleteRow() {
        sut.didSwipeToDeleteRow(item: TodoItemModel(priority: TodoItemPriority.medium, title: "Test 1", isFavorite: false, dateCreated: Date.now))
        
        XCTAssertTrue(listViewControllerDelegateSpy.showAlertControllerWasCalled)
    }
}
