//
//  UILabelExtension.swift
//  BasicNoteApp
//
//  Created by Furkan on 17.07.2023.
//

import Foundation
import UIKit

extension UILabel {
    func addIcon(icon: UIImage, text: String, iconSize: CGSize, xOffset: CGFloat, yOffset: CGFloat) {
           let attachment = NSTextAttachment()
           attachment.image = icon
           attachment.bounds = CGRect(origin: CGPoint(x: xOffset, y: yOffset), size: iconSize)

           let attachmentString = NSAttributedString(attachment: attachment)
           let mutableAttributedString = NSMutableAttributedString(string: "")
           mutableAttributedString.append(attachmentString)

           let textString = NSMutableAttributedString(string: " \(text)")
           mutableAttributedString.append(textString)

           self.attributedText = mutableAttributedString
       }
}
