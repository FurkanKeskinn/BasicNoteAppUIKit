//
//  Register.swift
//  BasicNoteApp
//
//  Created by Furkan on 15.08.2023.
//

import Foundation

struct Register: Codable {
    let fullName, email, password: String
    
    enum CodingKeys: String, CodingKey {
        case fullName = "full_name"
        case email, password
    }
}
