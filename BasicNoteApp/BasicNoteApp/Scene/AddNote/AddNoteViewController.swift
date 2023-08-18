//
//  AddNoteViewController.swift
//  BasicNoteApp
//
//  Created by Furkan on 20.07.2023.
//

import UIKit

class AddNoteViewController: UIViewController {
    
    private let titleTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = L10n.Placeholder.title
        textField.font = .font(.interMedium, size: .h2)
        textField.textColor = .appBlack
        return textField
    }()
    
    private let descriptionTextView: UITextView = {
        let textView = UITextView()
        textView.font = .font(.interMedium, size: .h4)
        textView.textColor = .appDarkGray
        textView.addPlaceholder(L10n.Placeholder.description)
        return textView
    }()
    
    private let saveNoteButton: UIButton = {
        let button = UIButton()
        button.setTitle(L10n.General.saveNote, for: .normal)
        button.titleLabel?.font = .font(.interSemiBold, size: .h4)
        button.backgroundColor = .appPurple100
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private let stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 8
        stack.alignment = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        return scroll
    }()
    
    private var viewModel: AddNoteViewModelProtocol
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        applyConstraints()
        backButton()
        subscribeViewModel()
    }
    
    init(viewModel: AddNoteViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    // swiftlint:disable fatal_error
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // swiftlint:enable fatal_error
}

// MARK: - Layout
extension AddNoteViewController {
    
    private func setupViews() {
        view.addSubview(scrollView)
        scrollView.addSubview(stackView)
        scrollView.addSubview(saveNoteButton)
        stackView.addArrangedSubview(titleTextField)
        stackView.addArrangedSubview(descriptionTextView)
        title = L10n.Modules.noteTitle("Add")
        view.backgroundColor = .systemBackground
    }
    
    private func applyConstraints() {
        
        let saveNoteButtonConstraints = [
            saveNoteButton.topAnchor.constraint(equalTo: descriptionTextView.bottomAnchor, constant: 41),
            saveNoteButton.widthAnchor.constraint(equalToConstant: 142),
            saveNoteButton.heightAnchor.constraint(equalToConstant: 41),
            saveNoteButton.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor)
        ]
        let descriptionTextViewConstraints = [
            descriptionTextView.heightAnchor.constraint(equalToConstant: 327)
        ]
        let stackViewConstraints = [
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 23),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24)
        ]
        let scrollViewConstraints = [
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ]
        let allConstraints = [
            saveNoteButtonConstraints,
            descriptionTextViewConstraints,
            stackViewConstraints,
            scrollViewConstraints
        ]
        NSLayoutConstraint.activate(allConstraints.flatMap { $0 })
    }
}

// MARK: - Action
extension AddNoteViewController {
    private func backButton() {
        let backbutton = UIBarButtonItem(image: UIImage(asset: Asset.Icons.back), style: .done, target: self, action: #selector(backbuttonTapped))
        navigationItem.leftBarButtonItem = backbutton
        navigationController?.navigationBar.tintColor = .appBlack
    }
    
    @objc private func backbuttonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func saveButtonTapped() {
        guard let titleText = self.titleTextField.text, let descriptionText = self.descriptionTextView.text, !titleText.isEmpty, !descriptionText.isEmpty else {
            return self.presentModalController()
        }
        viewModel.createNote(title: titleText, note: descriptionText)
    }
}

// MARK: - Bottom Sheet
extension AddNoteViewController {
    
    private func presentModalController() {
        let customBottomSheetVC = CustomBottomSheetView()
        customBottomSheetVC.modalPresentationStyle = .overCurrentContext
        
        let image = UIImage(asset: Asset.Icons.error)
        let title = L10n.Modules.LoginViewController.toastMessage
        let actionButtonTitle = L10n.General.ok
        
        customBottomSheetVC.setupContent(withImage: image, title: title, description: nil, actionButtonTitle: actionButtonTitle)
        customBottomSheetVC.actionButton.addTarget(self, action: #selector(actionButtonTapped), for: .touchUpInside)
        
        self.present(customBottomSheetVC, animated: true, completion: nil)
    }
    
    @objc private func actionButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
}

// MARK: - Response Data
extension AddNoteViewController {
    func subscribeViewModel() {
        viewModel.didSuccessAddNote = { [weak self] isSuccess in
            let notesViewController = NotesViewController(viewModel: NotesViewModel())
            self?.navigationController?.pushViewController(notesViewController, animated: true)
        }
    }
}

import SwiftUI
#if DEBUG

@available(iOS 13, *)
struct AddNoteViewControllerPreview: PreviewProvider {
    static var previews: some View {
        AddNoteViewController(viewModel: AddNoteViewModel()).showPreview()
    }
}
#endif
