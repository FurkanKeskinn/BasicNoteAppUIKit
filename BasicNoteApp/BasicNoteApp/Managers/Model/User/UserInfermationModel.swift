//
//  UserInfermationModel.swift
//  BasicNoteApp
//
//  Created by Furkan on 15.08.2023.
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
