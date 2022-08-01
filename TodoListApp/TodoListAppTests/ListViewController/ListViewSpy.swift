//
//  ListViewSpy.swift
//  TodoListAppTests
//
//  Created by Elias Gabriel on 31/07/22.

@testable import TodoListApp
import UIKit

final class ListViewSpy: UIView {
    var items: [[TodoItemModel]] = []
    weak var delegate: ListViewDelegate?
    var numberOfRowsInSegmentWasCalled: Bool = false
    var updatedContentListWasCalled: Bool = false
    var makeAccessoryViewWasCalled: Bool = false
    var makeCellWasCalled: Bool = false
    var setupWasCalled: Bool = false
}

extension ListViewSpy: ListViewConfiguration {
    
    func numberOfRowsInSegment() -> Int {
        numberOfRowsInSegmentWasCalled = true
        return 0
    }
    
    func updatedContentList() {
        updatedContentListWasCalled = true
    }
    
    func makeAccessoryView(image: UIImage?) -> UIImageView {
        makeAccessoryViewWasCalled = true
        return UIImageView()
    }
    
    func makeCell(indexPath: IndexPath) -> UITableViewCell {
        makeCellWasCalled = true
        return UITableViewCell()
    }
    
    func setup(viewModel: [[TodoItemModel]]) {
        setupWasCalled = true
    }
    
    
}


