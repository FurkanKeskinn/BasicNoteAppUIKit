//
//  ForgotPasswordViewController.swift
//  BasicNoteApp
//
//  Created by Furkan on 18.07.2023.
//

import UIKit

class ForgotPasswordViewController: UIViewController {
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = L10n.Modules.forgotPassword
        label.font = .font(.interSemiBold, size: .h1)
        label.textColor = .appBlack
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = L10n.Modules.ForgotPasswordViewController.descriptionText
        label.font = .font(.interMedium, size: .h5)
        label.numberOfLines = 0
        label.textAlignment = .center
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
    
    private let emailTextField = FloatLabelTextField()
    
    private let emailInvalidLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .font(.interMedium, size: .small)
        label.addIcon(icon: UIImage(asset: Asset.Icons.icError)!, text: L10n.Error.emailInvalid, iconSize: CGSize(width: 16, height: 16), xOffset: -8, yOffset: -4)
        label.textColor = .appRed
        label.isHidden = true
        return label
    }()
    
    private let resetPasswordButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .appPurple50
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(L10n.General.resetPassword, for: .normal)
        button.titleLabel?.font = .font(.interSemiBold, size: .h4)
        button.setTitleColor(.appPurple100, for: .normal)
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(resetPasswordTapped), for: .touchUpInside)
        return button
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
    
    private var viewModel: ResetPasswordViewModelProtocol = ResetPasswordViewModel()
    var message: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        contentConfigure()
        setupViews()
        applyConstraints()
        backButton()
        subscribeViewModel()
        emailTextField.delegate = self
    }
}

// MARK: - Configure
extension ForgotPasswordViewController {
    private func contentConfigure() {
        emailTextField.autocapitalizationType = .none
        emailTextField.keyboardType = .emailAddress
        emailTextField.title = L10n.Placeholder.email
    }
}

// MARK: - Layout
extension ForgotPasswordViewController {
    
    private func setupViews() {
        view.addSubview(scrollView)
        scrollView.addSubview(mainStackView)
        mainStackView.addArrangedSubview(titleStackView)
        mainStackView.addArrangedSubview(emailTextField)
        mainStackView.addArrangedSubview(emailInvalidLabel)
        mainStackView.addArrangedSubview(resetPasswordButton)
        titleStackView.addArrangedSubview(titleLabel)
        titleStackView.addArrangedSubview(descriptionLabel)
        view.backgroundColor = .systemBackground
    }
    
    private func applyConstraints() {
        let titleStackViewConstraints = [
            titleStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ]
        let emailTextFieldConstraints = [
            emailTextField.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 40)
        ]
        let emailInvalidLabelConstraints = [
            emailInvalidLabel.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 8),
            emailInvalidLabel.leadingAnchor.constraint(equalTo: mainStackView.leadingAnchor, constant: 8)
        ]
        let resetPasswordButtonConstraints = [
            resetPasswordButton.topAnchor.constraint(equalTo: emailInvalidLabel.bottomAnchor, constant: 24),
            resetPasswordButton.heightAnchor.constraint(equalToConstant: 63)
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
            emailTextFieldConstraints,
            emailInvalidLabelConstraints,
            resetPasswordButtonConstraints,
            scrollViewConstraints,
            mainStackViewConstraints
        ]
        NSLayoutConstraint.activate(allConstraints.flatMap { $0 })
    }
}

// MARK: - Action
extension ForgotPasswordViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    private func backButton() {
        let backbutton = UIBarButtonItem(image: UIImage(asset: Asset.Icons.back), style: .done, target: self, action: #selector(backbuttonTapped))
        navigationItem.leftBarButtonItem = backbutton
        navigationController?.navigationBar.tintColor = .appBlack
    }
    
    @objc private func backbuttonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func resetPasswordTapped() {
        guard let emailAddress = self.emailTextField.text  else {return}
        viewModel.getResetPasswordUserData(email: emailAddress)
        presentModalController()
    }
}

// MARK: - Bottom Sheet
extension ForgotPasswordViewController {
    
    private func presentModalController() {
        let customBottomSheetVC = CustomBottomSheetView()
        customBottomSheetVC.modalPresentationStyle = .overCurrentContext
        
        let image = UIImage(asset: Asset.Icons.icSuccess)
        let title = L10n.Modules.ForgotPasswordViewController.titletoastMessage
        let description = L10n.Modules.ForgotPasswordViewController.toastMessage(self.emailTextField.text ?? "test@gmail.com")
        let actionButtonTitle = L10n.General.login
        
        customBottomSheetVC.setupContent(withImage: image, title: title, description: description, actionButtonTitle: actionButtonTitle)
        customBottomSheetVC.actionButton.addTarget(self, action: #selector(actionButtonTapped), for: .touchUpInside)
        
        self.present(customBottomSheetVC, animated: true, completion: nil)
    }
    
    @objc
    private func actionButtonTapped() {
        self.dismiss(animated: true) {
            self.navigationController?.popViewController(animated: true)
        }
    }
}

// MARK: - Response Data
extension ForgotPasswordViewController {
    func subscribeViewModel() {
        viewModel.reloadData
    }
}

// MARK: - Button Color Change
extension ForgotPasswordViewController {
    private func updateButtonBackgroundColor() {
        let validation = Validation()
        if let email = emailTextField.text,
           validation.isValidEmail(email) {
            resetPasswordButton.backgroundColor = .appPurple100
            resetPasswordButton.setTitleColor(.appWhite, for: .normal)
        } else {
            
            resetPasswordButton.backgroundColor = .appPurple50
            resetPasswordButton.setTitleColor(.appPurple100, for: .normal)
        }
    }
}

// MARK: - Textfields isValid
extension ForgotPasswordViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == emailTextField {
            
            let currentText = textField.text ?? ""
            let newText = (currentText as NSString).replacingCharacters(in: range, with: string)
            
            let validation = Validation()
            if textField == emailTextField {
                if !validation.isValidEmail(newText) {
                    emailInvalidLabel.isHidden = false
                    emailTextField.isValid = true
                    
                } else {
                    emailInvalidLabel.isHidden = true
                    emailTextField.isValid = false
                }
            }
            updateButtonBackgroundColor()
        }
        return true
    }
}

import SwiftUI
#if DEBUG

@available(iOS 13, *)
struct ForgotPasswordViewControllerPreview: PreviewProvider {
    static var previews: some View {
        ForgotPasswordViewController().showPreview()
    }
}
#endif
