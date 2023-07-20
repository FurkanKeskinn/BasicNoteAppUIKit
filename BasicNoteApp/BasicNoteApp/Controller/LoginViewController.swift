//
//  LoginViewController.swift
//  BasicNoteApp
//
//  Created by Furkan on 18.07.2023.
//

import UIKit

class LoginViewController: UIViewController {

    private let titleLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = L10n.Modules.LoginViewController.title
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
        label.numberOfLines = 0
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
    
    private let buttonLogin: UIButton = {
       let button = UIButton()
        button.backgroundColor = .appPurple50
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(L10n.General.login, for: .normal)
        button.titleLabel?.font = .font(.interSemiBold, size: .h4)
        button.setTitleColor(.appPurple100, for: .normal)
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(buttonLoginTapped), for: .touchUpInside)
        return button
    }()
    
    private let haventAccountLabel: UILabel = {
       let label = UILabel()
        label.text = L10n.Modules.LoginViewController.bottomText
        label.font = .font(.interMedium, size: .h5)
        label.textColor = .appDarkGray
        return label
    }()
    private let signUpLabel: UILabel = {
       let label = UILabel()
        label.text = L10n.General.signUpNow
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
        contentConfigure()
        setupViews()
        applyConstraints()
        addTapGestureToSignInLabel()
        addTapGestureToForgotPassword()
    }
    
    private func contentConfigure() {
        emailTextField.autocapitalizationType = .none
        emailTextField.keyboardType = .emailAddress
        emailTextField.title = L10n.Placeholder.email
        passwordTextField.keyboardType = .emailAddress
        passwordTextField.title = L10n.Placeholder.password
        passwordTextField.isSecureTextEntry = true
    }
}
// MARK: - Layout
extension LoginViewController {
    
    private func setupViews() {
        view.addSubview(scrollView)
        scrollView.addSubview(mainStackView)
        scrollView.addSubview(bottomStackView)
        mainStackView.addArrangedSubview(titleStackView)
        mainStackView.addArrangedSubview(textFieldstackView)
        mainStackView.addArrangedSubview(passwordInvalidLabel)
        mainStackView.addArrangedSubview(forgotPasswordStackView)
        mainStackView.addArrangedSubview(buttonLogin)
        titleStackView.addArrangedSubview(titleLabel)
        titleStackView.addArrangedSubview(descriptionLabel)
        textFieldstackView.addArrangedSubview(emailTextField)
        textFieldstackView.addArrangedSubview(passwordTextField)
        forgotPasswordStackView.addArrangedSubview(forgotPasswordLabel)
        bottomStackView.addArrangedSubview(haventAccountLabel)
        bottomStackView.addArrangedSubview(signUpLabel)
        view.backgroundColor = .systemBackground
     }
    
    private func applyConstraints() {
        let titleStackViewConstraints = [
            titleStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ]
        let textFieldstackViewConstraints = [
            textFieldstackView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 40)
        ]
        let passwordInvalidLabelConstraints = [
            passwordInvalidLabel.topAnchor.constraint(equalTo: textFieldstackView.bottomAnchor, constant: 8),
            passwordInvalidLabel.leadingAnchor.constraint(equalTo: mainStackView.leadingAnchor, constant: 8)
        ]
        let forgotPasswordStackViewConstraints = [
            forgotPasswordStackView.topAnchor.constraint(equalTo: passwordInvalidLabel.bottomAnchor, constant: 12)
        ]
        let buttonLoginConstraints = [
            buttonLogin.topAnchor.constraint(equalTo: forgotPasswordLabel.bottomAnchor, constant: 24),
            buttonLogin.heightAnchor.constraint(equalToConstant: 63)
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
       let allConstraints = [
            titleStackViewConstraints,
            textFieldstackViewConstraints,
            passwordInvalidLabelConstraints,
            forgotPasswordStackViewConstraints,
            buttonLoginConstraints,
            bottomStackViewConstraints,
            scrollViewConstraints,
            mainStackViewConstraints
        ]
        NSLayoutConstraint.activate(allConstraints.flatMap { $0 })
    }
}
// MARK: - Action
extension LoginViewController {
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    private func addTapGestureToForgotPassword() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(forgotPasswordTapped))
        forgotPasswordLabel.isUserInteractionEnabled = true
        forgotPasswordLabel.addGestureRecognizer(tapGesture)
    }
    @objc private func forgotPasswordTapped() {
        let forgotPasswordViewController = ForgotPasswordViewController()
        navigationController?.pushViewController(forgotPasswordViewController, animated: true)
    }
    
    private func addTapGestureToSignInLabel() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(signUpLabelTapped))
        signUpLabel.isUserInteractionEnabled = true
        signUpLabel.addGestureRecognizer(tapGesture)
    }
    @objc private func signUpLabelTapped() {
        let registerViewController = RegisterViewController() //
        navigationController?.pushViewController(registerViewController, animated: true)
    }
    
    @objc private func buttonLoginTapped() {
        let notesViewController = NotesViewController() //
        navigationController?.pushViewController(notesViewController, animated: true)
    }
}
import SwiftUI
#if DEBUG

@available(iOS 13, *)
struct LoginViewControllerPreview: PreviewProvider {
    static var previews: some View {
        LoginViewController().showPreview()
    }
}
#endif
