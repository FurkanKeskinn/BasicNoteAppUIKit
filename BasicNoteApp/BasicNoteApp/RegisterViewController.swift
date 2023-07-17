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
    
    private let passwordInvalidLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = L10n.Error.passwordInvalid
        label.font = .font(.interMedium, size: .small)
        label.addIcon(icon: UIImage(asset: Asset.Icons.icError)!, text: L10n.Error.passwordInvalid, iconSize: CGSize(width: 16, height: 16), xOffset: -8, yOffset: -4)
        label.textColor = .appRed
        label.isHidden = false
        return label
    }()
    
    private let forgotPasswordLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = L10n.Modules.forgotPassword
        label.font = .font(.interMedium, size: .h5)
        label.textColor = .appBlack
        return label
    }()
    
    private let forgotPasswordStackView: UIStackView = {
    let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .trailing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
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
    
    private let bottomStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.spacing = 16
        stackView.distribution = .fill
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
        view.backgroundColor = .systemBackground
        contentConfigure()
        setupViews()
        applyConstraints()
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
    
    private func setupViews(){
        view.addSubview(scrollView)
        scrollView.addSubview(mainStackView)
        scrollView.addSubview(bottomStackView)
        mainStackView.addArrangedSubview(titleStackView)
        mainStackView.addArrangedSubview(textFieldstackView)
        mainStackView.addArrangedSubview(passwordInvalidLabel)
        mainStackView.addArrangedSubview(forgotPasswordStackView)
        mainStackView.addArrangedSubview(buttonRegister)
        titleStackView.addArrangedSubview(titleLabel)
        titleStackView.addArrangedSubview(descriptionLabel)
        textFieldstackView.addArrangedSubview(fullnameTextField)
        textFieldstackView.addArrangedSubview(emailTextField)
        textFieldstackView.addArrangedSubview(passwordTextField)
        forgotPasswordStackView.addArrangedSubview(forgotPasswordLabel)
        bottomStackView.addArrangedSubview(haveAccountLabel)
        bottomStackView.addArrangedSubview(signInLabel)
     }
    
    private func applyConstraints() {
        
        let titleStackViewConstraints = [
            titleStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ]
        
        let textFieldstackViewConstraints = [
            textFieldstackView.topAnchor.constraint(equalTo: titleStackView.bottomAnchor, constant: 40)
        ]
        
        let passwordInvalidLabelConstraints = [
            passwordInvalidLabel.topAnchor.constraint(equalTo: textFieldstackView.bottomAnchor, constant: 8),
            passwordInvalidLabel.leadingAnchor.constraint(equalTo: mainStackView.leadingAnchor, constant: 8)
        ]
        
        let forgotPasswordStackViewConstraints = [
            forgotPasswordStackView.topAnchor.constraint(equalTo: passwordInvalidLabel.bottomAnchor, constant: 12)
        ]
        
        let buttonRegisterConstraints = [
            buttonRegister.topAnchor.constraint(equalTo: forgotPasswordLabel.bottomAnchor, constant: 24),
            buttonRegister.heightAnchor.constraint(equalToConstant: 63)
        ]
        
        let bottomStackViewConstraints = [
            bottomStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -38),
            bottomStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor)

        ]
        
        let scrollViewConstraints = [
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
                ]
        let mainStackViewConstraints = [
            mainStackView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 96),
            mainStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            mainStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            mainStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -38)
              
        ]
        
        NSLayoutConstraint.activate(titleStackViewConstraints)
        NSLayoutConstraint.activate(textFieldstackViewConstraints)
        NSLayoutConstraint.activate(passwordInvalidLabelConstraints)
        NSLayoutConstraint.activate(forgotPasswordStackViewConstraints)
        NSLayoutConstraint.activate(buttonRegisterConstraints)
        NSLayoutConstraint.activate(bottomStackViewConstraints)
        NSLayoutConstraint.activate(scrollViewConstraints)
        NSLayoutConstraint.activate(mainStackViewConstraints)
        
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



