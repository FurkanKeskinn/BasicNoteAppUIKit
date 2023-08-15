//
//  DataClass.swift
//  BasicNoteApp
//
//  Created by Furkan on 15.08.2023.
//

import Foundation

struct DataClass: Codable {
    let accessToken, tokenType: String
    
    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case tokenType = "token_type"
    }
}
