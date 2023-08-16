//
//  UIViewControllerExtenstion.swift
//  BasicNoteApp
//
//  Created by Furkan on 14.07.2023.
//

import Foundation
import UIKit
import SwiftUI
extension UIViewController {
    
    @available(iOS 13, *)
    private struct Preview: UIViewControllerRepresentable {
        let viewController: UIViewController
        
        func makeUIViewController(context: Context) -> UIViewController {
            return viewController
        }
        
        func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
            //
        }
    }
    
    @available(iOS 13, *)
    func showPreview() -> some View {
        Preview(viewController: self)
    }
}
