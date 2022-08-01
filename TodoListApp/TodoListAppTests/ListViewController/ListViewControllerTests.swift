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
    
    override func setUp() {
        super.setUp()
        listManagerSpy = ListManagerSpy()
        listViewSpy = ListViewSpy()
        sut = ListViewController(listManager: listManagerSpy, customView: listViewSpy)
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
}
