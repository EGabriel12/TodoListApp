//
//  MainCoordinatorTests.swift
//  TodoListAppTests
//
//  Created by Elias Gabriel on 13/08/22.
//

import XCTest
@testable import TodoListApp

final class MainCoordinatorTests: XCTestCase {
    var sut: MainCoordinator!
    var coreDataManagerSpy: CoreDataManagerSpy!
    var mockNavigationController: MockNavigationController!
    
    override func setUp() {
        super.setUp()
        
        mockNavigationController = MockNavigationController()
        coreDataManagerSpy = CoreDataManagerSpy(entityName: "MockEntityName")
        sut = MainCoordinator(navigationController: mockNavigationController, coreDataManager: coreDataManagerSpy)
    }
    
    func testStart() {
        sut.start()
        
        let viewController = try? cast(from: mockNavigationController.pushedVC, to: ListViewController.self)
        XCTAssertNotNil(viewController?.delegate)
        XCTAssertTrue(coreDataManagerSpy.loadPersistentStoresWasCalled)
    }
    
    func testPopViewController() {
        sut.popViewController()
        
        XCTAssertNil(mockNavigationController.topViewController)
        XCTAssertTrue(mockNavigationController.popViewControllerWasCalled)
    }
    
    func testRouterToEditTodoViewController() {
        sut.routerToEditTodoViewController(todoItem: TodoItemModel(priority: TodoItemPriority.medium, title: "Edit test", isFavorite: true, dateCreated: Date.now))
        
        let viewController = try? cast(from: mockNavigationController.pushedVC, to: EditTodoViewController.self)
        XCTAssertNotNil(viewController?.delegate)
    }
    
    func testRouterToAddTodoViewController() {
        sut.routerToAddNewTodoViewController()
        
        let viewController = try? cast(from: mockNavigationController.pushedVC, to: AddNewTodoViewController.self)
        XCTAssertNotNil(viewController?.delegate)
    }
    
    func testShowAlertController() {
        sut.start()
        sut.showAlertController(
            title: "Do you want to delete this item?",
            message: "After this operation, the item cannot be recovered",
            primaryAction: UIAlertAction())
        
        let viewController = try? cast(from: mockNavigationController.presentedVC, to: UIAlertController.self)
        XCTAssertNotNil(viewController)
    }
}

