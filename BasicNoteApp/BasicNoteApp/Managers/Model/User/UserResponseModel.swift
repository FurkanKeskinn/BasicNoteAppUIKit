//
//  UserResponseModel.swift
//  BasicNoteApp
//
//  Created by Furkan on 15.08.2023.
//

import Foundation

// MARK: - User Response Model
struct UserResponseModel: Codable {
    let code: String
    let data: UserDataClass
    let message: String
}
