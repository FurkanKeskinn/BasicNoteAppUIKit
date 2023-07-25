//
//  UITextViewExtension.swift
//  BasicNoteApp
//
//  Created by Furkan on 20.07.2023.
//

import Foundation
import UIKit
extension UITextView {
    func addPlaceholder(_ placeholder: String) {
        let placeholderLabel = UILabel()
        placeholderLabel.text = placeholder
        placeholderLabel.textColor = .appDarkGray
        placeholderLabel.font = .font(.interMedium, size: .h4)
        placeholderLabel.sizeToFit()
        placeholderLabel.tag = 999
        placeholderLabel.isHidden = !self.text.isEmpty
        self.addSubview(placeholderLabel)
        self.delegate = self
        placeholderLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            placeholderLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            placeholderLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5)
        ])
    }
}

extension UITextView: UITextViewDelegate {
    public func textViewDidChange(_ textView: UITextView) {
        if let placeholderLabel = textView.viewWithTag(999) as? UILabel {
            placeholderLabel.isHidden = !textView.text.isEmpty
        }
    }
}
