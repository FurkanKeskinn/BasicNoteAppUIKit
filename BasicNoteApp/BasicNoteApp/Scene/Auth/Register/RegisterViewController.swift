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
    
    private let emailInvalidLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .font(.interMedium, size: .small)
        label.addIcon(icon: UIImage(asset: Asset.Icons.icError)!, text: L10n.Error.emailInvalid, iconSize: CGSize(width: 16, height: 16), xOffset: -8, yOffset: -4)
        label.textColor = .appRed
        return label
    }()
    
    private let emailInvalidLabelStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.alignment = .leading
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.isHidden = true
        return stackView
    }()
    
    private let passwordInvalidLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .font(.interMedium, size: .small)
        label.addIcon(icon: UIImage(asset: Asset.Icons.icError)!, text: L10n.Error.passwordInvalid, iconSize: CGSize(width: 16, height: 16), xOffset: -8, yOffset: -4)
        label.textColor = .appRed
        label.isHidden = true
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
    
    private let registerButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .appPurple50
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(L10n.General.register, for: .normal)
        button.titleLabel?.font = .font(.interSemiBold, size: .h4)
        button.setTitleColor(.appPurple100, for: .normal)
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(buttonRegisterTapped), for: .touchUpInside)
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
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private var viewModel: RegisterViewModelProtocol
    
    override func viewDidLoad() {
        super.viewDidLoad()
        contentConfigure()
        setupViews()
        applyConstraints()
        addTapGestureToSignInLabel()
        addTapGestureToForgotPassword()
        subscribeViewModel()
        fullnameTextField.delegate = self
        emailTextField.delegate = self
        passwordTextField.delegate = self
    }
    init(viewModel: RegisterViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    // swiftlint:disable fatal_error
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // swiftlint:enable fatal_error
}

// MARK: - Configure
extension RegisterViewController {
    
    private func contentConfigure() {
        fullnameTextField.title = L10n.Placeholder.fullname
        emailTextField.autocapitalizationType = .none
        emailTextField.keyboardType = .emailAddress
        emailTextField.title = L10n.Placeholder.email
        passwordTextField.title = L10n.Placeholder.password
        passwordTextField.isSecureTextEntry = true
    }
}

// MARK: - Layout
extension RegisterViewController {
    
    private func setupViews() {
        view.addSubview(scrollView)
        scrollView.addSubview(mainStackView)
        scrollView.addSubview(bottomStackView)
        mainStackView.addArrangedSubview(titleStackView)
        mainStackView.addArrangedSubview(textFieldstackView)
        mainStackView.addArrangedSubview(passwordInvalidLabel)
        mainStackView.addArrangedSubview(forgotPasswordStackView)
        mainStackView.addArrangedSubview(registerButton)
        titleStackView.addArrangedSubview(titleLabel)
        titleStackView.addArrangedSubview(descriptionLabel)
        textFieldstackView.addArrangedSubview(fullnameTextField)
        textFieldstackView.addArrangedSubview(emailTextField)
        textFieldstackView.addArrangedSubview(emailInvalidLabelStackView)
        textFieldstackView.addArrangedSubview(passwordTextField)
        emailInvalidLabelStackView.addArrangedSubview(emailInvalidLabel)
        forgotPasswordStackView.addArrangedSubview(forgotPasswordLabel)
        bottomStackView.addArrangedSubview(haveAccountLabel)
        bottomStackView.addArrangedSubview(signInLabel)
        view.backgroundColor = .systemBackground
    }
    
    private func applyConstraints() {
        let titleStackViewConstraints = [
            titleStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ]
        let textFieldstackViewConstraints = [
            textFieldstackView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 40)
        ]
        let emailInvalidLabelConstraints = [
            emailInvalidLabel.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 8),
            emailInvalidLabel.leadingAnchor.constraint(equalTo: mainStackView.leadingAnchor, constant: 8)
        ]
        let passwordInvalidLabelConstraints = [
            passwordInvalidLabel.topAnchor.constraint(equalTo: textFieldstackView.bottomAnchor, constant: 8),
            passwordInvalidLabel.leadingAnchor.constraint(equalTo: mainStackView.leadingAnchor, constant: 8)
        ]
        let forgotPasswordStackViewConstraints = [
            forgotPasswordStackView.topAnchor.constraint(equalTo: passwordInvalidLabel.bottomAnchor, constant: 12)
        ]
        let registerButtonConstraints = [
            registerButton.topAnchor.constraint(equalTo: forgotPasswordLabel.bottomAnchor, constant: 24),
            registerButton.heightAnchor.constraint(equalToConstant: 63)
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
            emailInvalidLabelConstraints,
            passwordInvalidLabelConstraints,
            forgotPasswordStackViewConstraints,
            registerButtonConstraints,
            bottomStackViewConstraints,
            scrollViewConstraints,
            mainStackViewConstraints
        ]
        NSLayoutConstraint.activate(allConstraints.flatMap { $0 })
    }
}

// MARK: - Action
extension RegisterViewController {
    
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
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(signInLabelTapped))
        signInLabel.isUserInteractionEnabled = true
        signInLabel.addGestureRecognizer(tapGesture)
    }
    @objc private func signInLabelTapped() {
        let loginViewController = LoginViewController(viewModel: LoginViewModel())
        navigationController?.pushViewController(loginViewController, animated: true)
    }
    
    @objc private func buttonRegisterTapped() {
        
        guard let fullName = self.fullnameTextField.text,
              let emailAddress = self.emailTextField.text,
              let password = self.passwordTextField.text,
              !fullName.isEmpty else {return}
        viewModel.getRegisterUserData(fullName: fullName, email: emailAddress, password: password)
    }
}

// MARK: - Response Data
extension RegisterViewController {
    func subscribeViewModel() {
        viewModel.didSuccessRegister = { [weak self] isSuccess in
            let notesViewController = NotesViewController(coder: NSCoder())!
            self?.navigationController?.pushViewController(notesViewController, animated: true)
            
        }
    }
}

// MARK: - Textfields isValid
extension RegisterViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == emailTextField || textField == passwordTextField {
            
            let currentText = textField.text ?? ""
            let newText = (currentText as NSString).replacingCharacters(in: range, with: string)
            
            let validation = Validation()
            if textField == emailTextField {
                if !validation.isValidEmail(newText) {
                    emailInvalidLabelStackView.isHidden = false
                    emailTextField.isValid = true
                } else {
                    emailInvalidLabelStackView.isHidden = true
                    emailTextField.isValid = false
                }
            } else if textField == passwordTextField {
                if !validation.isValidPassword(newText) {
                    passwordInvalidLabel.isHidden = false
                    passwordTextField.isValid = true
                } else {
                    passwordInvalidLabel.isHidden = true
                    passwordTextField.isValid = false
                }
            }
            updateButtonBackgroundColor()
        }
        return true
    }
}

// MARK: - Button Color Change
extension RegisterViewController {
    private func updateButtonBackgroundColor() {
        let validation = Validation()
        if let fullName = fullnameTextField.text,
           let email = emailTextField.text,
           let password = passwordTextField.text,
           !fullName.isEmpty,
           validation.isValidEmail(email),
           password.count >= 6 {
            registerButton.backgroundColor = .appPurple100
            registerButton.setTitleColor(.appWhite, for: .normal)
        } else {
            registerButton.backgroundColor = .appPurple50
            registerButton.setTitleColor(.appPurple100, for: .normal)
        }
    }
}

import SwiftUI
#if DEBUG

@available(iOS 13, *)
struct RegisterViewControllerPreview: PreviewProvider {
    static var previews: some View {
        RegisterViewController(viewModel: RegisterViewModel()).showPreview()
    }
}
#endif
