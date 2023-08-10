//
//  User.swift
//  BasicNoteApp
//
//  Created by Furkan on 2.08.2023.
//

import Foundation

// MARK: - User Infermation Model
struct UserInfermationModel: Codable {
    let fullName, email: String
    
    enum CodingKeys: String, CodingKey {
        case fullName = "full_name"
        case email
    }
}

// MARK: - User Response Model
struct UserResponseModel: Codable {
    let code: String
    let data: UserDataClass
    let message: String
}

// MARK: - Change email or fullname Data Class
struct UserDataClass: Codable {
    let id: Int
    let fullName: String?
    let email: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case fullName = "full_name"
        case email
    }
}


// MARK: - All Note Response Model
struct AllNotesResponseModel: Codable {
    let code: String
    let data: AllNotesDataClass
    let message: String
}

// MARK: - User Notes Data Class
struct AllNotesDataClass: Codable {
    let currentPage: Int
    let data: [Datum]
    let firstPageURL: String
    let from, lastPage: Int
    let lastPageURL: String
    let links: [Link]
    let nextPageURL: String?
    let path: String
    let perPage: Int
    let prevPageURL: String?
    let to, total: Int
    
    enum CodingKeys: String, CodingKey {
        case currentPage = "current_page"
        case data
        case firstPageURL = "first_page_url"
        case from
        case lastPage = "last_page"
        case lastPageURL = "last_page_url"
        case links
        case nextPageURL = "next_page_url"
        case path
        case perPage = "per_page"
        case prevPageURL = "prev_page_url"
        case to, total
    }
}

// MARK: - Datum
struct Datum: Codable {
    let id: Int
    let title: String
    let note: String
}

// MARK: - Link
struct Link: Codable {
    let url: String?
    let label: String
    let active: Bool
}

// MARK: - Change Password
struct ChangePasswordModel: Codable {
    let password, newPassword, newPasswordConfirmation: String
    
    enum CodingKeys: String, CodingKey {
        case password
        case newPassword = "new_password"
        case newPasswordConfirmation = "new_password_confirmation"
    }
}

// MARK: - Change Passwrod Response Model
struct ChangePasswordResponseModel: Codable {
    let code: String
    let data: String?
    let message: String
}
