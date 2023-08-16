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
    
    private let saveButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .appPurple50
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(L10n.General.save, for: .normal)
        button.titleLabel?.font = .font(.interSemiBold, size: .h4)
        button.setTitleColor(.appPurple100, for: .normal)
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
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
    
    private var viewModel: ChangePasswordViewModelProtocol
    
    override func viewDidLoad() {
        super.viewDidLoad()
        contentConfigure()
        setupViews()
        applyConstraints()
        backButton()
        subscribeViewModel()
        passwordTextField.delegate = self
        newPasswordTextField.delegate = self
        retypeNewPasswordTextField.delegate = self
    }
    
    init(viewModel: ChangePasswordViewModelProtocol) {
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
extension ChangePasswordViewController {
    private func contentConfigure() {
        passwordTextField.title = L10n.Placeholder.password
        passwordTextField.isSecureTextEntry = true
        newPasswordTextField.title = L10n.Placeholder.newPassword
        newPasswordTextField.isSecureTextEntry = true
        retypeNewPasswordTextField.title = L10n.Placeholder.retypeNewPassword
        retypeNewPasswordTextField.isSecureTextEntry = true
    }
}

// MARK: - Layout
extension ChangePasswordViewController {
    private func setupViews() {
        view.addSubview(scrollView)
        scrollView.addSubview(mainStackView)
        mainStackView.addArrangedSubview(textFieldstackView)
        mainStackView.addArrangedSubview(saveButton)
        textFieldstackView.addArrangedSubview(passwordTextField)
        textFieldstackView.addArrangedSubview(newPasswordTextField)
        textFieldstackView.addArrangedSubview(retypeNewPasswordTextField)
        title = L10n.Modules.ChangePasswordViewController.title
        view.backgroundColor = .systemBackground
    }
    
    private func applyConstraints() {
        
        let saveButtonConstraints = [
            saveButton.topAnchor.constraint(equalTo: textFieldstackView.bottomAnchor, constant: 24),
            saveButton.heightAnchor.constraint(equalToConstant: 63)
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
            saveButtonConstraints,
            scrollViewConstraints,
            mainStackViewConstraints
        ]
        NSLayoutConstraint.activate(allConstraints.flatMap { $0 })
    }
}

// MARK: - Action
extension ChangePasswordViewController {
    private func backButton() {
        let backbutton = UIBarButtonItem(image: UIImage(asset: Asset.Icons.back), style: .done, target: self, action: #selector(backbuttonTapped))
        navigationItem.leftBarButtonItem = backbutton
        navigationController?.navigationBar.tintColor = .appBlack
    }
    
    @objc private func backbuttonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func saveButtonTapped() {
        
        guard let password = passwordTextField.text, let newPassword = newPasswordTextField.text, let newPasswordConfirmation = retypeNewPasswordTextField.text else {
            return
        }
        guard !password.isEmpty || !newPassword.isEmpty || !newPasswordConfirmation.isEmpty, newPassword == newPasswordConfirmation else {
            return self.presentModalController()
        }
        
        viewModel.getPasswordUpdateData(password: password, newPassword: newPassword, newPasswordConfirmation: newPasswordConfirmation)
    }
}

// MARK: - Bottom Sheet
extension ChangePasswordViewController {
    
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
extension ChangePasswordViewController {
    func subscribeViewModel() {
        viewModel.didSuccessChangePassword = { [weak self] isSuccess in
            let loginViewController = LoginViewController(viewModel: LoginViewModel())
            self?.navigationController?.pushViewController(loginViewController, animated: true)
        }
    }
}

// MARK: - Button Color Change
extension ChangePasswordViewController: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == passwordTextField || textField == newPasswordTextField  || textField == retypeNewPasswordTextField {
            updateButtonBackgroundColor()
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == passwordTextField || textField == newPasswordTextField  || textField == retypeNewPasswordTextField {
            updateButtonBackgroundColor()
        }
    }
    
    private func updateButtonBackgroundColor() {
        if let password = passwordTextField.text,
           let newPassword = newPasswordTextField.text,
           let retypeNewPassword = retypeNewPasswordTextField.text,
           !password.isEmpty,
           !newPassword.isEmpty || !retypeNewPassword.isEmpty {
            saveButton.backgroundColor = .appPurple100
            saveButton.setTitleColor(.appWhite, for: .normal)
        } else {
            
            saveButton.backgroundColor = .appPurple50
            saveButton.setTitleColor(.appPurple100, for: .normal)
        }
    }
}

import SwiftUI
#if DEBUG

@available(iOS 13, *)
struct ChangePasswordViewControllerPreview: PreviewProvider {
    static var previews: some View {
        ChangePasswordViewController(viewModel: ChangePasswordViewModel()).showPreview()
    }
}
#endif
