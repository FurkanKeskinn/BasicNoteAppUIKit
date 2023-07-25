//
//  CustomBottomSheetView.swift
//  BasicNoteApp
//
//  Created by Furkan on 21.07.2023.
//

import Foundation
import UIKit

class CustomBottomSheetView: UIViewController {
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .font(.interSemiBold, size: .h4)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.textColor = .appBlack
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .font(.interMedium, size: .h4)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .appDarkGray
        return label
    }()
    
    let actionButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .appPurple100
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(L10n.General.resetPassword, for: .normal)
        button.titleLabel?.font = .font(.interSemiBold, size: .h4)
        button.setTitleColor(.appWhite, for: .normal)
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(actionButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private let contentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 16
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
    
    lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .appWhite
        view.layer.cornerRadius = 16
        view.clipsToBounds = true
        return view
    }()
    
    private let maxDimmedAlpha: CGFloat = 0.4
    
    private lazy var dimmedView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.alpha = maxDimmedAlpha
        
        return view
    }()
    
    private let dismissibleHeight: CGFloat = 200
    private var currentContainerHeight: CGFloat = 375
    private var containerViewHeightConstraint: NSLayoutConstraint?
    private var containerViewBottomConstraint: NSLayoutConstraint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureConstraints()
        setupPanGesture()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.handleCloseAction))
        dimmedView.addGestureRecognizer(tapGesture)
        
    }
    
    @objc func handleCloseAction() {
        animateDismissView()
    }
    @objc private func actionButtonTapped() {
        animateDismissView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        super.viewDidAppear(animated)
        
        animateShowDimmedView()
    }
    
    private func configureConstraints() {
        view.addSubview(dimmedView)
        view.addSubview(containerView)
        containerView.addSubview(scrollView)
        contentStackView.addArrangedSubview(imageView)
        contentStackView.addArrangedSubview(titleLabel)
        contentStackView.addArrangedSubview(descriptionLabel)
        mainStackView.addArrangedSubview(actionButton)
        scrollView.addSubview(contentStackView)
        scrollView.addSubview(mainStackView)
        dimmedView.translatesAutoresizingMaskIntoConstraints = false
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            dimmedView.topAnchor.constraint(equalTo: view.topAnchor),
            dimmedView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            dimmedView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            dimmedView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
        NSLayoutConstraint.activate([
            actionButton.topAnchor.constraint(equalTo: contentStackView.bottomAnchor, constant: 50),
            actionButton.heightAnchor.constraint(equalToConstant: 63),
            contentStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            contentStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            mainStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            mainStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            scrollView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 50),
            scrollView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -54)
        ])
        
        containerViewHeightConstraint = containerView.heightAnchor.constraint(equalToConstant: currentContainerHeight)
        containerViewBottomConstraint = containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        containerViewHeightConstraint?.isActive = true
        containerViewBottomConstraint?.isActive = true
    }
    
    private func setupPanGesture() {
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(self.handlePanGesture(gesture:)))
        panGesture.delaysTouchesBegan = false
        panGesture.delaysTouchesEnded = false
        
        view.addGestureRecognizer(panGesture)
        
    }
    
    @objc func handlePanGesture(gesture: UIPanGestureRecognizer) {
        
        let translation = gesture.translation(in: view)
        let isDraggingDown = translation.y > 0
        let newHeight = currentContainerHeight - translation.y
        
        switch gesture.state {
        case .changed:
            if newHeight < currentContainerHeight {
                containerViewHeightConstraint?.constant = newHeight
                view.layoutIfNeeded()
            }
        case .ended:
            if newHeight < dismissibleHeight {
                self.animateDismissView()
            }
            else if newHeight < currentContainerHeight {
                animateContainerHeight(currentContainerHeight)
            }
            else if newHeight < currentContainerHeight && isDraggingDown {
                animateContainerHeight(currentContainerHeight)
            }
            else if newHeight > currentContainerHeight && !isDraggingDown {
                animateContainerHeight(currentContainerHeight)
            }
        default:
            break
        }
    }
    
    private func animateContainerHeight(_ height: CGFloat) {
        
        UIView.animate(withDuration: 0.2) {
            self.containerViewHeightConstraint?.constant = height
            self.view.layoutIfNeeded()
        }
        
        currentContainerHeight = height
        
    }
    
    private func animateShowDimmedView() {
        UIView.animate(withDuration: 0.2) {
            self.dimmedView.alpha = self.maxDimmedAlpha
        }
    }
    
    private func animateDismissView() {
        
        dimmedView.alpha = maxDimmedAlpha
        UIView.animate(withDuration: 0.2) {
            self.dimmedView.alpha = 0
        } completion: { _ in
            self.dismiss(animated: false)
        }
        UIView.animate(withDuration: 0.1) {
            self.containerViewBottomConstraint?.constant = self.currentContainerHeight
            self.view.layoutIfNeeded()
        }
    }
}

// MARK: - Setup Content
extension CustomBottomSheetView {
    func setupContent(withImage image: UIImage?, title: String?, description: String?, actionButtonTitle: String?) {
           if let image = image {
               imageView.image = image
           }
           
           if let title = title {
               titleLabel.text = title
           }
           
           if let description = description {
               descriptionLabel.text = description
           }
           
           if let actionButtonTitle = actionButtonTitle {
               actionButton.setTitle(actionButtonTitle, for: .normal)
           }
       }
}
