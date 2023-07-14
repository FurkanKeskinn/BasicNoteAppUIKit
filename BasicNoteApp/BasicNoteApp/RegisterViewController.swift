//
//  RegisterViewController.swift
//  BasicNoteApp
//
//  Created by Furkan on 10.07.2023.
//

import UIKit

class RegisterViewController: UIViewController {

    private let titleLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = L10n.Modules.RegisterViewController.title
        label.font = .font(.interSemiBold, size: .h1)
        label.textColor = .appBlack
        return label
    }()
    private let descriptionLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = L10n.Modules.descriptionText
        label.font = .font(.interMedium, size: .h5)
        label.textColor = .appDarkGray
        return label
    }()
    
    private let titleStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let fullnameTextField = FloatLabelTextField()
    private let emailTextField = FloatLabelTextField()
    private let passwordTextField = FloatLabelTextField()
    
    private let textFieldstackView: UIStackView = {
    let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let passwordInvalidIcon: UIImageView = {
       let image = UIImageView()
        image.image = UIImage(asset: Asset.Icons.icError)
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let passwordInvalidLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = L10n.Error.passwordInvalid
        label.font = .font(.interMedium, size: .small)
        label.textColor = .appRed
        return label
    }()
    
    private let passwordInvalidStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 4
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.isHidden = false
        return stackView
    }()
    
    private let forgotPasswordLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = L10n.Modules.forgotPassword
        label.font = .font(.interMedium, size: .h5)
        label.textColor = .appBlack
        return label
    }()
    
    private let buttonRegister: UIButton = {
       let button = UIButton()
        button.backgroundColor = .appPurple50
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(L10n.General.register, for: .normal)
        button.titleLabel?.font = .font(.interSemiBold, size: .h4)
        button.setTitleColor(.appPurple100, for: .normal)
        button.layer.cornerRadius = 5
        return button
    }()
    
    private let haveAccountLabel: UILabel = {
       let label = UILabel()
        label.text = L10n.Modules.RegisterViewController.bottomText
        label.font = .font(.interMedium, size: .h5)
        label.textColor = .appDarkGray
        return label
    }()
    private let signInLabel: UILabel = {
       let label = UILabel()
        label.text = L10n.General.signInNow
        label.font = .font(.interMedium, size: .h5)
        label.textColor = .appPurple100
        return label
    }()
    
    private let bottomStackView : UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        contentConfigure()
        
    }
    
    private func contentConfigure(){
        fullnameTextField.title = L10n.Placeholder.fullname
        emailTextField.autocapitalizationType = .none
        emailTextField.keyboardType = .emailAddress
        emailTextField.title = L10n.Placeholder.email
        passwordTextField.keyboardType = .emailAddress
        passwordTextField.title = L10n.Placeholder.password
        passwordTextField.isSecureTextEntry = true
        passwordTextField.layer.borderColor = UIColor.appRed.cgColor

    }
}

extension RegisterViewController {
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupViews()
        applyConstraints()
    }
    
    private func setupViews(){
         view.addSubview(titleStackView)
         view.addSubview(textFieldstackView)
         view.addSubview(forgotPasswordLabel)
         view.addSubview(passwordInvalidStackView)
         view.addSubview(buttonRegister)
         view.addSubview(bottomStackView)
         titleStackView.addArrangedSubview(titleLabel)
         titleStackView.addArrangedSubview(descriptionLabel)
         textFieldstackView.addArrangedSubview(fullnameTextField)
         textFieldstackView.addArrangedSubview(emailTextField)
         textFieldstackView.addArrangedSubview(passwordTextField)
         passwordInvalidStackView.addArrangedSubview(passwordInvalidIcon)
         passwordInvalidStackView.addArrangedSubview(passwordInvalidLabel)
         bottomStackView.addArrangedSubview(haveAccountLabel)
         bottomStackView.addArrangedSubview(signInLabel)
        
     }
    
    private func applyConstraints() {
        
        let titleStackViewConstraints = [
            titleStackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 96),
            titleStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ]
        
        let textFieldstackViewConstraints = [
            textFieldstackView.topAnchor.constraint(equalTo: titleStackView.bottomAnchor, constant: 40),
            textFieldstackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            textFieldstackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24)
        ]
        
        let passwordInvalidStackViewConstraints = [
            passwordInvalidStackView.topAnchor.constraint(equalTo: textFieldstackView.bottomAnchor, constant: 8),
            passwordInvalidStackView.leadingAnchor.constraint(equalTo: textFieldstackView.leadingAnchor, constant: 8)
        ]
        
        let forgotPasswordLabelConstraints = [
            forgotPasswordLabel.topAnchor.constraint(equalTo: passwordInvalidStackView.bottomAnchor, constant: 12),
            forgotPasswordLabel.trailingAnchor.constraint(equalTo: textFieldstackView.trailingAnchor)
        ]
        
        let buttonRegisterConstraints = [
            buttonRegister.topAnchor.constraint(equalTo: forgotPasswordLabel.bottomAnchor, constant: 24),
            buttonRegister.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            buttonRegister.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            buttonRegister.heightAnchor.constraint(equalToConstant: 63)
        ]
        let bottomStackViewConstraints = [
            bottomStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -38),
            bottomStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor)

        ]
        
        NSLayoutConstraint.activate(titleStackViewConstraints)
        NSLayoutConstraint.activate(textFieldstackViewConstraints)
        NSLayoutConstraint.activate(passwordInvalidStackViewConstraints)
        NSLayoutConstraint.activate(forgotPasswordLabelConstraints)
        NSLayoutConstraint.activate(buttonRegisterConstraints)
        NSLayoutConstraint.activate(bottomStackViewConstraints)
    }
}

import SwiftUI
#if DEBUG

@available(iOS 13, *)
struct RegisterViewControllerPreview: PreviewProvider {
    static var previews: some View {
        
        RegisterViewController().showPreview()
    }
}
#endif



