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
    
    private let loginButton: UIButton = {
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
    
    private var viewModel: LoginViewModelProtocol
    
    override func viewDidLoad() {
        super.viewDidLoad()
        contentConfigure()
        setupViews()
        applyConstraints()
        addTapGestureToSignInLabel()
        addTapGestureToForgotPassword()
        subscribeViewModel()
        emailTextField.delegate = self
        passwordTextField.delegate = self
    }
    init(viewModel: LoginViewModelProtocol) {
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
extension LoginViewController {
    
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
        mainStackView.addArrangedSubview(forgotPasswordStackView)
        mainStackView.addArrangedSubview(loginButton)
        
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
        let forgotPasswordStackViewConstraints = [
            forgotPasswordStackView.topAnchor.constraint(equalTo: textFieldstackView.bottomAnchor, constant: 12)
        ]
        let loginButtonConstraints = [
            loginButton.topAnchor.constraint(equalTo: forgotPasswordLabel.bottomAnchor, constant: 24),
            loginButton.heightAnchor.constraint(equalToConstant: 63)
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
            forgotPasswordStackViewConstraints,
            loginButtonConstraints,
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
        let registerViewController = RegisterViewController(viewModel: RegisterViewModel())
        navigationController?.pushViewController(registerViewController, animated: true)
    }
    
    @objc private func buttonLoginTapped() {
        
        guard let emailAddress = self.emailTextField.text,
              let password = self.passwordTextField.text,
              !emailAddress.isEmpty,
              !password.isEmpty else {return}
        viewModel.getLoginUserData(email: emailAddress, password: password)
    }
}

// MARK: - Bottom Sheet
extension LoginViewController {
    
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
extension LoginViewController {
    func subscribeViewModel() {
        viewModel.didSuccessLogin = { [weak self] isSuccess in
            if isSuccess {
                let notesViewController = NotesViewController(viewModel: NotesViewModel(), viewModelEdit: EditNoteViewModel())
                self?.navigationController?.pushViewController(notesViewController, animated: true)
            } else {
                self?.presentModalController()
            }
        }
    }
}

// MARK: - Button Color Change
extension LoginViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == emailTextField || textField == passwordTextField {
            updateButtonBackgroundColor()
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == passwordTextField || textField == emailTextField {
            updateButtonBackgroundColor()
        }
    }
    
    private func updateButtonBackgroundColor() {
        if let email = emailTextField.text, let password = passwordTextField.text, !email.isEmpty || !password.isEmpty {
            loginButton.backgroundColor = .appPurple100
            loginButton.setTitleColor(.appWhite, for: .normal)
            
        } else {
            
            loginButton.backgroundColor = .appPurple50
            loginButton.setTitleColor(.appPurple100, for: .normal)
        }
    }
}

import SwiftUI
#if DEBUG

@available(iOS 13, *)
struct LoginViewControllerPreview: PreviewProvider {
    static var previews: some View {
        LoginViewController(viewModel: LoginViewModel()).showPreview()
    }
}
#endif
