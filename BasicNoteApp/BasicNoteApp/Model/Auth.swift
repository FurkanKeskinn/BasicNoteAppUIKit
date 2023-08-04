//
//  Auth.swift
//  BasicNoteApp
//
//  Created by Furkan on 2.08.2023.
//

import Foundation

// MARK: - Register Model
struct Register: Codable {
    let fullName, email, password: String
    
    enum CodingKeys: String, CodingKey {
        case fullName = "full_name"
        case email, password
    }
}

// MARK: - Login Model
struct Login: Codable {
    let email, password: String
}

// MARK: - Forgat Password Model
struct ForgotPassword: Codable {
    let email: String
}

// MARK: - Auth Response Model
struct AuthResponseModel: Codable {
    let code: String
    let data: DataClass
    let message: String
}

// MARK: - Data Class
struct DataClass: Codable {
    let accessToken, tokenType: String
    
    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case tokenType = "token_type"
    }
}

// MARK: - Forgot Password Response Model
struct ForgotPasswordResponseModel: Codable {
    let code: String
    let data: String?
    let message: String
}
