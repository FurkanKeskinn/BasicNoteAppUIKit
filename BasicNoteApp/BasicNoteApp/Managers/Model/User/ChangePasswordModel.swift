//
//  ChangePasswordModel.swift
//  BasicNoteApp
//
//  Created by Furkan on 15.08.2023.
//

import Foundation

// MARK: - Change Password
struct ChangePasswordModel: Codable {
    let password, newPassword, newPasswordConfirmation: String
    
    enum CodingKeys: String, CodingKey {
        case password
        case newPassword = "new_password"
        case newPasswordConfirmation = "new_password_confirmation"
    }
}
