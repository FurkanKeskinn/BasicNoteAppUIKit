//
//  NoteResponseModel.swift
//  BasicNoteApp
//
//  Created by Furkan on 15.08.2023.
//

import Foundation

// MARK: - Note Response Model
struct NoteResponseModel: Codable {
    let code: String
    let data: NoteDataModel?
    let message: String
}
