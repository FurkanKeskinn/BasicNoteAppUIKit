//
//  PreviewViewController.swift
//  BasicNoteApp
//
//  Created by Furkan on 2.08.2023.
//

import Foundation

class PreviewViewController: UIViewController {
    
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
    
    private var viewModel: NoteViewModelProtocol = NoteViewModel()
    static var id: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        applyConstraints()
        backButton()
        viewModel.delegateNote(delegate: self)
        viewModel.getNote(id: PreviewViewController.id!)
    }
}

// MARK: - Layout
extension PreviewViewController {
    
    private func setupViews() {
        view.addSubview(scrollView)
        scrollView.addSubview(stackView)
        stackView.addArrangedSubview(titleTextField)
        stackView.addArrangedSubview(descriptionTextView)
        title = L10n.Modules.noteTitle("")
        view.backgroundColor = .systemBackground
    }
    
    private func applyConstraints() {
        
        
        let descriptionTextViewConstraints = [
            descriptionTextView.heightAnchor.constraint(equalToConstant: 500)
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
            descriptionTextViewConstraints,
            stackViewConstraints,
            scrollViewConstraints
        ]
        NSLayoutConstraint.activate(allConstraints.flatMap { $0 })
    }
}

// MARK: - Action
extension PreviewViewController {
    private func backButton() {
        let backbutton = UIBarButtonItem(image: UIImage(asset: Asset.Icons.back), style: .done, target: self, action: #selector(backbuttonTapped))
        navigationItem.leftBarButtonItem = backbutton
    }
    
    @objc private func backbuttonTapped() {
        navigationController?.popViewController(animated: true)
    }
}

// MARK: - Response Data
extension PreviewViewController: NoteResponseData {
    internal func noteData(noteResponse: NoteResponseModel) {
        DispatchQueue.main.async { [weak self] in
            self?.titleTextField.text = noteResponse.data?.title
            self?.descriptionTextView.removePlaceholder()
            self?.descriptionTextView.text = noteResponse.data?.note
        }
    }
}

import SwiftUI
#if DEBUG

@available(iOS 13, *)
struct PreviewViewControllerPreview: PreviewProvider {
    static var previews: some View {
        PreviewViewController().showPreview()
    }
}
#endif
