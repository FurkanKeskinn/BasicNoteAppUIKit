//
//  Note.swift
//  BasicNoteApp
//
//  Created by Furkan on 27.07.2023.
//

import Foundation

// MARK: - Create Note Model
struct NoteModel: Codable {
    let title: String
    let note: String
}

// MARK: - Note Data Model
struct NoteDataModel: Codable {
    let title: String
    let note: String
    let id: Int
}

// MARK: - Note Response Model
struct NoteResponseModel: Codable {
    let code: String
    let data: NoteDataModel?
    let message: String
}

// MARK: - Note Detail Model
struct NoteDetailModel: Codable {
    let id: Int
}
