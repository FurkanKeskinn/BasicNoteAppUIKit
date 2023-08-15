//
//  ProfileViewController.swift
//  BasicNoteApp
//
//  Created by Furkan on 19.07.2023.
//

import UIKit

class ProfileViewController: UIViewController {
    
    private let fullnameTextField = FloatLabelTextField()
    private let emailTextField = FloatLabelTextField()
    
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
    
    private let changePasswordLabel: UILabel = {
        let label = UILabel()
        label.text = L10n.Modules.ProfileViewController.changePassword
        label.font = .font(.interSemiBold, size: .h6)
        label.textColor = .appPurple100
        label.textAlignment = .center
        return label
    }()
    
    private let signOutLabel: UILabel = {
        let label = UILabel()
        label.text = L10n.Modules.ProfileViewController.signOut
        label.font = .font(.interSemiBold, size: .h6)
        label.textColor = .appRed
        label.textAlignment = .center
        return label
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
    
    private var viewModelDetail: UserDetailViewModelProtocol = UserDetailViewModel()
    
    private var viewModelUpdate: UserUpdateViewModelProtocol = UserUpdateViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Profile"
        contentConfigure()
        setupViews()
        applyConstraints()
        backButton()
        addTapGestureToChangePassword()
        addTapGestureTosignOut()
        subscribeUserDetailViewModel()
        subscribeUserUpdateViewModel()
        viewModelDetail.getUserDetailData()
        fullnameTextField.delegate = self
        emailTextField.delegate = self
    }
}

// MARK: - Configure
extension ProfileViewController {
    
    private func contentConfigure() {
        fullnameTextField.title = L10n.Placeholder.fullname
        emailTextField.autocapitalizationType = .none
        emailTextField.keyboardType = .emailAddress
        emailTextField.title = L10n.Placeholder.email
    }
}

// MARK: - Layout
extension ProfileViewController {
    
    private func setupViews() {
        view.addSubview(scrollView)
        scrollView.addSubview(mainStackView)
        mainStackView.addArrangedSubview(textFieldstackView)
        mainStackView.addArrangedSubview(saveButton)
        mainStackView.addArrangedSubview(changePasswordLabel)
        mainStackView.addArrangedSubview(signOutLabel)
        textFieldstackView.addArrangedSubview(fullnameTextField)
        textFieldstackView.addArrangedSubview(emailTextField)
        view.backgroundColor = .systemBackground
    }
    
    private func applyConstraints() {
        
        let saveButtonConstraints = [
            saveButton.topAnchor.constraint(equalTo: textFieldstackView.bottomAnchor, constant: 24),
            saveButton.heightAnchor.constraint(equalToConstant: 63)
        ]
        let signOutLabelConstraints = [
            signOutLabel.topAnchor.constraint(equalTo: changePasswordLabel.bottomAnchor, constant: 8)
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
            signOutLabelConstraints,
            scrollViewConstraints,
            mainStackViewConstraints
        ]
        NSLayoutConstraint.activate(allConstraints.flatMap { $0 })
    }
}

// MARK: - Action
extension ProfileViewController {
    
    private func backButton() {
        let backbutton = UIBarButtonItem(image: UIImage(asset: Asset.Icons.back), style: .done, target: self, action: #selector(backbuttonTapped))
        navigationItem.leftBarButtonItem = backbutton
        navigationController?.navigationBar.tintColor = .appBlack
    }
    
    @objc private func backbuttonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func saveButtonTapped() {
        guard let newFullName = fullnameTextField.text, let newEmail = emailTextField.text, !newEmail.isEmpty, !newFullName.isEmpty else {
            return
        }
        viewModelUpdate.getUserUpdateData(fullName: newFullName, email: newEmail)
        
        let notesViewController = NotesViewController()
        navigationController?.pushViewController(notesViewController, animated: true)
    }
    
    private func addTapGestureToChangePassword() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(changePasswordTapped))
        changePasswordLabel.isUserInteractionEnabled = true
        changePasswordLabel.addGestureRecognizer(tapGesture)
    }
    @objc private func changePasswordTapped() {
        let changePasswordViewController = ChangePasswordViewController()
        navigationController?.pushViewController(changePasswordViewController, animated: true)
    }
    
    private func addTapGestureTosignOut() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(signOutTapped))
        signOutLabel.isUserInteractionEnabled = true
        signOutLabel.addGestureRecognizer(tapGesture)
    }
    @objc private func signOutTapped() {
        let loginViewController = LoginViewController()
        navigationController?.pushViewController(loginViewController, animated: true)
    }
}

// MARK: - Response Data
extension ProfileViewController {
    func subscribeUserDetailViewModel() {
        viewModelDetail.reloadData = { user in
            self.fullnameTextField.text = user.data.fullName
            self.emailTextField.text = user.data.email
        }
    }
    func subscribeUserUpdateViewModel() {
        viewModelUpdate.reloadData
    }
}

// MARK: - Button Color Change
extension ProfileViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == fullnameTextField || textField == emailTextField {
            updateButtonBackgroundColor()
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == fullnameTextField || textField == emailTextField {
            updateButtonBackgroundColor()
        }
    }
    
    private func updateButtonBackgroundColor() {
        if let email = emailTextField.text, let fullName = fullnameTextField.text, !email.isEmpty || !fullName.isEmpty {
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
struct ProfileViewControllerPreview: PreviewProvider {
    static var previews: some View {
        ProfileViewController().showPreview()
    }
}
#endif
