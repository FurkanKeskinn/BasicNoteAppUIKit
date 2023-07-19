//
//  ChangePasswordViewController.swift
//  BasicNoteApp
//
//  Created by Furkan on 19.07.2023.
//

import UIKit

class ChangePasswordViewController: UIViewController {

    private let passwordTextField = FloatLabelTextField()
    private let newPasswordTextField = FloatLabelTextField()
    private let retypeNewPasswordTextField = FloatLabelTextField()
    
    private let textFieldstackView: UIStackView = {
       let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let buttonSave: UIButton = {
       let button = UIButton()
        button.backgroundColor = .appPurple50
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(L10n.General.save, for: .normal)
        button.titleLabel?.font = .font(.interSemiBold, size: .h4)
        button.setTitleColor(.appPurple100, for: .normal)
        button.layer.cornerRadius = 5
        return button
    }()
    
    private let mainStackView: UIStackView = {
       let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.spacing = 24
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let scrollView: UIScrollView = {
       let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        contentConfigure()
        setupViews()
        applyConstraints()
    }
    
    private func contentConfigure() {
        passwordTextField.title = L10n.Placeholder.password
        passwordTextField.isSecureTextEntry = true
        newPasswordTextField.title = L10n.Placeholder.newPassword
        newPasswordTextField.isSecureTextEntry = true
        retypeNewPasswordTextField.title = L10n.Placeholder.retypeNewPassword
        retypeNewPasswordTextField.isSecureTextEntry = true
    }
}

extension ChangePasswordViewController {
    
    private func setupViews() {
        view.addSubview(scrollView)
        scrollView.addSubview(mainStackView)
        mainStackView.addArrangedSubview(textFieldstackView)
        mainStackView.addArrangedSubview(buttonSave)
        textFieldstackView.addArrangedSubview(passwordTextField)
        textFieldstackView.addArrangedSubview(newPasswordTextField)
        textFieldstackView.addArrangedSubview(retypeNewPasswordTextField)
     }
    
    private func applyConstraints() {
        
        let buttonSaveConstraints = [
            buttonSave.topAnchor.constraint(equalTo: textFieldstackView.bottomAnchor, constant: 24),
            buttonSave.heightAnchor.constraint(equalToConstant: 63),
        ]
        
        let scrollViewConstraints = [
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ]
        let mainStackViewConstraints = [
            mainStackView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 24),
            mainStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            mainStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            mainStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
        ]
        let allConstraints = [
            buttonSaveConstraints,
            scrollViewConstraints,
            mainStackViewConstraints
        ]
        NSLayoutConstraint.activate(allConstraints.flatMap { $0 })
    }
}
import SwiftUI
#if DEBUG

@available(iOS 13, *)
struct ChangePasswordViewControllerPreview: PreviewProvider {
    static var previews: some View {
        ChangePasswordViewController().showPreview()
    }
}
#endif
