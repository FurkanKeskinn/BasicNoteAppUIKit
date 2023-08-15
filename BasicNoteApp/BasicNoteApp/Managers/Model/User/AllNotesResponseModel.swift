//
//  AllNotesResponseModel.swift
//  BasicNoteApp
//
//  Created by Furkan on 15.08.2023.
//

import Foundation

// MARK: - All Note Response Model
struct AllNotesResponseModel: Codable {
    let code: String
    let data: AllNotesDataClass
    let message: String
}
