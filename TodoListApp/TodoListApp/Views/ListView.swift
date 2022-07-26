//
//  ListView.swift
//  TodoListApp
//
//  Created by Elias Gabriel on 24/07/22.
//

import UIKit

protocol ListViewConfiguration: UIView {
    
    var delegate: ListViewDelegate? { get set }
    var items: [[TodoItemModel]] { get }
    func numberOfRowsInSegment() -> Int
    func updatedContentList()
    func makeAccessoryView(image: UIImage?) -> UIImageView
    func makeCell(indexPath: IndexPath) -> UITableViewCell
    func setup(viewModel: [[TodoItemModel]])
}

protocol ListViewDelegate: AnyObject {
    func didSwipeToDeleteRow(item: TodoItemModel)
}

final class ListView: BaseView {
    
    // MARK: - Properties
    private (set) var items = [[TodoItemModel]]()
    weak var delegate: ListViewDelegate?
    
    // MARK: - UI
    private lazy var segmentedControl: UISegmentedControl = {
        let control = UISegmentedControl(items: TodoItemPriority.allCases.map({ $0.title }))
        control.translatesAutoresizingMaskIntoConstraints = false
        control.selectedSegmentIndex = 1
        control.addAction(UIAction(handler: { [self] _ in updatedContentList() }), for: .valueChanged)
        return control
    }()
    
    private lazy var tableView: UITableView = {
        let view = UITableView(frame: .zero, style: .insetGrouped)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.delegate = self
        view.dataSource = self
        return view
    }()
    
    override func subviews() {
        addSubview(segmentedControl)
        addSubview(tableView)
    }
    
    override func layout() {
        addConstraints([
            segmentedControl.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16),
            segmentedControl.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16),
            segmentedControl.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16),

            tableView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 16),
            tableView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16),
            tableView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16),
            tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -16)
        ])
    }
    
}

// MARK: - ListViewConfiguration
extension ListView: ListViewConfiguration {
    func numberOfRowsInSegment() -> Int {
        return items[segmentedControl.selectedSegmentIndex].count
    }
    
    func updatedContentList() {
        DispatchQueue.main.async { [self] in
            tableView.reloadData()
        }
    }
    
    func makeAccessoryView(image: UIImage?) -> UIImageView {
        let view = UIImageView(image: image)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.tintColor = .yellow
        return view
    }
    
    func makeCell(indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        cell.textLabel?.text =  "●"
        cell.textLabel?.textAlignment = .left
        cell.textLabel?.textColor = items[segmentedControl.selectedSegmentIndex][indexPath.item].priority.color
        cell.detailTextLabel?.text = items[segmentedControl.selectedSegmentIndex][indexPath.item].title
        cell.accessoryView = makeAccessoryView(image: items[segmentedControl.selectedSegmentIndex][indexPath.item].imageIsFavorite)
        cell.accessoryView?.tintColor = items[segmentedControl.selectedSegmentIndex][indexPath.item].priority.color
        return cell
    }
    
    func setup(viewModel: [[TodoItemModel]]) {
        items = viewModel
    }
}

// MARK: - UITableViewDataSource
extension ListView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        numberOfRowsInSegment()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        makeCell(indexPath: indexPath)
    }
}

// MARK: - UITableViewDelegate
extension ListView: UITableViewDelegate {
    // TODO - Edit a Todo Item
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            delegate?.didSwipeToDeleteRow(item: items[segmentedControl.selectedSegmentIndex][indexPath.item])
//            items[segmentedControl.selectedSegmentIndex].remove(at: indexPath.item)
//            updatedContentList()
        }
    }
}
