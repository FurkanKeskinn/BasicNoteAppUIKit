//
//  UserDataClass.swift
//  BasicNoteApp
//
//  Created by Furkan on 15.08.2023.
//

import Foundation

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
