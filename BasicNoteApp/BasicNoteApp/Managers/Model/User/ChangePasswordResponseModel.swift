//
//  ChangePasswordResponseModel.swift
//  BasicNoteApp
//
//  Created by Furkan on 15.08.2023.
//

import Foundation

// MARK: - Change Passwrod Response Model
struct ChangePasswordResponseModel: Codable {
    let code: String
    let data: String?
    let message: String
}

