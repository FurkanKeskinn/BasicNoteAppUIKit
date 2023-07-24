//
//  FloatLabelTextField.swift
//  BasicNoteApp
//
//  Created by Furkan on 14.07.2023.
//

import Foundation
import UIKit

public class FloatLabelTextField: UITextField {
    
    private let titleLabel = UILabel()
    
    public var title: String? {
        willSet {
            placeholder = nil
            attributedPlaceholder = nil
            titleLabel.text = newValue
            titleLabel.sizeToFit()
        }
    }
    
    private var insets: UIEdgeInsets {
        let insets = UIEdgeInsets(top: 27, left: 18, bottom: 9, right: 18)
        return insets
    }
    
    public override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: insets)
    }
    
    public override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: insets)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureContents()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureContents()
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        placeholder = nil
        attributedPlaceholder = nil
        updateTitlePosition()
        if isFirstResponder || !text!.isEmpty {
            setTitleToTop(animate: true)
        } else {
            setTitleToCenter(animate: true)
        }
        layer.borderColor = isFirstResponder ? UIColor.appPurple100.cgColor : UIColor.appLightGray.cgColor
    }
    
    private func configureContents() {
        addSubview(titleLabel)
        heightAnchor.constraint(equalToConstant: 53).isActive = true
        borderStyle = .none
        layer.borderWidth = 1
        layer.cornerRadius = 5
        layer.borderColor = UIColor.appLightGray.cgColor
        font = .font(.interMedium, size: .h6)
        textColor = .appBlack
    }
    
    private func updateTitlePosition() {
        titleLabel.frame.origin.x = insets.left
        titleLabel.frame.size.width = frame.size.width - insets.left - insets.right
    }
    
    private func setTitleToTop(animate: Bool) {
        guard animate else { return }
        UIView.animate(withDuration: 0.25, delay: 0, options: [.beginFromCurrentState, .curveEaseOut], animations: { [weak self] in
            self?.configureTitleForTop()
        }, completion: nil)
    }
    
    private func setTitleToCenter(animate: Bool) {
        guard animate else { return }
        UIView.animate(withDuration: 0.25, delay: 0, options: [.beginFromCurrentState, .curveEaseIn], animations: { [weak self] in
            self?.configureTitleForCenter()
        }, completion: nil)
    }
    
    private func configureTitleForTop() {
        let contentHeight = frame.size.height
        let titleHeight = titleLabel.frame.size.height
        titleLabel.font = .font(.interMedium, size: .small)
        titleLabel.textColor = .appDarkGray
        titleLabel.frame.origin.y = (contentHeight / 2) - (titleHeight)
    }
    
    private func configureTitleForCenter() {
        let contentHeight = frame.size.height
        let titleHeight = titleLabel.frame.size.height
        titleLabel.font = .font(.interMedium, size: .h6)
        titleLabel.textColor = .appDarkGray
        titleLabel.frame.origin.y = (contentHeight / 2) - (titleHeight / 2)
    }
}
