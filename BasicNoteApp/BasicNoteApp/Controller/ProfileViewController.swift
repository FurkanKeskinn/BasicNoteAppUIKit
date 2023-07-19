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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        contentConfigure()
        setupViews()
        applyConstraints()
    }
    
    private func contentConfigure() {
        fullnameTextField.title = L10n.Placeholder.fullname
        emailTextField.autocapitalizationType = .none
        emailTextField.keyboardType = .emailAddress
        emailTextField.title = L10n.Placeholder.email
    }
}

extension ProfileViewController {
    
    private func setupViews() {
        view.addSubview(scrollView)
        scrollView.addSubview(mainStackView)
        mainStackView.addArrangedSubview(textFieldstackView)
        mainStackView.addArrangedSubview(buttonSave)
        mainStackView.addArrangedSubview(changePasswordLabel)
        mainStackView.addArrangedSubview(signOutLabel)
        
        textFieldstackView.addArrangedSubview(fullnameTextField)
        textFieldstackView.addArrangedSubview(emailTextField)
     }
    
    private func applyConstraints() {
        
        let buttonSaveConstraints = [
            buttonSave.topAnchor.constraint(equalTo: textFieldstackView.bottomAnchor, constant: 24),
            buttonSave.heightAnchor.constraint(equalToConstant: 63),
        ]
        let signOutLabelConstraints = [
            signOutLabel.topAnchor.constraint(equalTo: changePasswordLabel.bottomAnchor, constant: 8),
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
            signOutLabelConstraints,
            scrollViewConstraints,
            mainStackViewConstraints
        ]
        NSLayoutConstraint.activate(allConstraints.flatMap { $0 })
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
