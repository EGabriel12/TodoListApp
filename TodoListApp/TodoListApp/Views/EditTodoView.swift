//
//  EditTodoView.swift
//  TodoListApp
//
//  Created by Elias Gabriel on 27/07/22.
//

import UIKit

protocol EditTodoViewConfiguration: UIView {
    var delegate: EditTodoViewDelegate? { get set }
    var todoItem: TodoItemModel? { get }
    func setup(viewModel: TodoItemModel)
}

protocol EditTodoViewDelegate: AnyObject {
    func didTouchUpSaveButton(item: TodoItemModel)
}

final class EditTodoView: BaseView {
    
    // MARK: - Properties
    weak var delegate: EditTodoViewDelegate?
    private(set) var todoItem: TodoItemModel?
    
    // MARK: - UI
    private lazy var contentStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [titleTextField, priorityStackView, isFavoriteStackView])
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .vertical
        view.spacing = 16
        return view
    }()
    
    private lazy var titleTextField: UITextField = {
        let view = UITextField()
        view.placeholder = "Insert here"
        view.translatesAutoresizingMaskIntoConstraints = false
        view.borderStyle = .roundedRect
        return view
    }()
    
    private lazy var priorityStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [priorityLabel, priorityTextField])
        view.axis = .horizontal
        view.spacing = 8
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var priorityLabel: UILabel = {
        let view = UILabel()
        view.text = "Priority: "
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var priorityPickerView: UIPickerView = {
        let view = UIPickerView()
        view.delegate = self
        view.dataSource = self
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var priorityTextField: UITextField = {
        let view = UITextField()
        view.placeholder = "Input here"
        view.inputView = priorityPickerView
        view.textAlignment = .center
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var isFavoriteStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [isFavoriteLabel, isFavoriteSwitch])
        view.axis = .horizontal
        view.spacing = 8
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var isFavoriteLabel: UILabel = {
        let view = UILabel()
        view.text = "Is Favorite: "
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var isFavoriteSwitch: UISwitch = {
        let control = UISwitch()
        control.translatesAutoresizingMaskIntoConstraints = false
        return control
    }()
    
    private lazy var saveButton: UIButton = {
        let button = UIButton(configuration: .bordered(), primaryAction: nil)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Save", for: .normal)
        return button
    }()
    
    
    
    // MARK: - CustomViewCodeProtocol
    override func subviews() {
        addSubview(contentStackView)
        addSubview(saveButton)
    }
    
    override func layout() {
        addConstraints([
            contentStackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16),
            contentStackView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16),
            contentStackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
            saveButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -16),
            saveButton.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16),
            saveButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16)
        ])
       
    }
    
    // MARK: - UIResponder
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        endEditing(true)
    }
    
    private func didTouchUpSaveButton(_ action: UIAction) -> Void {
        
    }
    
    func setup(viewModel: TodoItemModel) {
        self.todoItem = viewModel
    }
}

// MARK: - EditTodoViewConfiguration
extension EditTodoView: EditTodoViewConfiguration {}

extension EditTodoView: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        TodoItemPriority.allCases[row].title
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        priorityTextField.text = TodoItemPriority.allCases[row].title
    }
}

extension EditTodoView: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        TodoItemPriority.allCases.count
    }
}
