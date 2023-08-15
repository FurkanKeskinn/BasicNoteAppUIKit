//
//  NoteDataModel.swift
//  BasicNoteApp
//
//  Created by Furkan on 15.08.2023.
//

import Foundation

// MARK: - Note Data Model
struct NoteDataModel: Codable {
    let title: String
    let note: String
    let id: Int
}
