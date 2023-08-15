//
//  AuthResponseModel.swift
//  BasicNoteApp
//
//  Created by Furkan on 15.08.2023.
//

import Foundation

struct AuthResponseModel: Codable {
    let code: String
    let data: DataClass?
    let message: String
}
