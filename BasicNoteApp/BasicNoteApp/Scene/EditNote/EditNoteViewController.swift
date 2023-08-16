//
//  EditNoteViewController.swift
//  BasicNoteApp
//
//  Created by Furkan on 20.07.2023.
//

import UIKit

class EditNoteViewController: UIViewController {
    
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
    
    private let editNoteButton: UIButton = {
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
    
    private var viewModelUpdate: EditNoteViewModelProtocol
    
    private var viewModelDetail: NoteViewModelProtocol
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        applyConstraints()
        backButton()
        subscribeUpdateViewModel()
        viewModelDetail.getNote(id: viewModelUpdate.id!)
    }
    
    init(viewModelUpdate: EditNoteViewModelProtocol, viewModelDetail: NoteViewModelProtocol) {
        self.viewModelUpdate = viewModelUpdate
        self.viewModelDetail = viewModelDetail
        super.init(nibName: nil, bundle: nil)
    }
    
    // swiftlint:disable fatal_error
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // swiftlint:enable fatal_error
}

// MARK: - Layout
extension EditNoteViewController {
    
    private func setupViews() {
        view.addSubview(scrollView)
        scrollView.addSubview(stackView)
        scrollView.addSubview(editNoteButton)
        stackView.addArrangedSubview(titleTextField)
        stackView.addArrangedSubview(descriptionTextView)
        title = L10n.Modules.noteTitle("Edit")
        view.backgroundColor = .systemBackground
    }
    
    private func applyConstraints() {
        
        let editNoteButtonConstraints = [
            editNoteButton.topAnchor.constraint(equalTo: descriptionTextView.bottomAnchor, constant: 41),
            editNoteButton.widthAnchor.constraint(equalToConstant: 142),
            editNoteButton.heightAnchor.constraint(equalToConstant: 41),
            editNoteButton.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor)
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
            editNoteButtonConstraints,
            descriptionTextViewConstraints,
            stackViewConstraints,
            scrollViewConstraints
        ]
        NSLayoutConstraint.activate(allConstraints.flatMap { $0 })
    }
}

// MARK: - Action
extension EditNoteViewController {
    private func backButton() {
        let backbutton = UIBarButtonItem(image: UIImage(asset: Asset.Icons.back), style: .done, target: self, action: #selector(backbuttonTapped))
        navigationItem.leftBarButtonItem = backbutton
    }
    
    @objc private func backbuttonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func saveButtonTapped() {
        guard let id = viewModelUpdate.id, let newTitle = titleTextField.text, let newNote = descriptionTextView.text, !newTitle.isEmpty, !newNote.isEmpty else {
            return self.presentModalController()
        }
        viewModelUpdate.updateNote(id: id, title: newTitle, note: newNote)
    }
}

// MARK: - Bottom Sheet
extension EditNoteViewController {
    
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
extension EditNoteViewController {
    internal func subscribeUpdateViewModel() {
        viewModelDetail.reloadData = { note in
            self.titleTextField.text = note.data?.title
            self.descriptionTextView.removePlaceholder()
            self.descriptionTextView.text = note.data?.note
        }
        viewModelUpdate.didSuccessUpdateNote = { [weak self] isSuccess in
            self?.navigationController?.popViewController(animated: true)
        }
    }
}

import SwiftUI
#if DEBUG

@available(iOS 13, *)
struct EditNoteViewControllerPreview: PreviewProvider {
    static var previews: some View {
        EditNoteViewController(coder: NSCoder())?.showPreview()
    }
}
#endif
