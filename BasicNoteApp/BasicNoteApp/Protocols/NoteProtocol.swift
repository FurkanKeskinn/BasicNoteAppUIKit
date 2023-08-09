//
//  NoteProtocol.swift
//  BasicNoteApp
//
//  Created by Furkan on 27.07.2023.
//

import Foundation

// MARK: - Detail Note
protocol NoteViewModelProtocol {
    func getNote(id: Int)
    var noteDetailResponseData: NoteResponseData? {get}
    func delegateNote(delegate: NoteResponseData)
}

// MARK: - Delete Note
protocol NoteDeleteViewModelProtocol {
    func deleteNote(id: Int, completion: @escaping (Result<Void, APIError>) -> Void)
    var noteDeleteResponseData: NoteResponseData? {get}
    func delegateNoteDelete(delegate: NoteResponseData)
}

// MARK: - Create Note
protocol NoteCreateViewModelProtocol {
    func createNote(title: String, note: String)
    var noteCreateResponseData: NoteResponseData? {get}
    func delegateNoteCreate(delegate: NoteResponseData)
}

// MARK: - Update Note
protocol NoteUpdateViewModelProtocol {
    func updateNote(id: Int, title: String, note: String)
    var noteUpdateResponseData: NoteResponseData? {get}
    func delegateNoteUpdate(delegate: NoteResponseData)
}

protocol NoteResponseData {
    func noteData(noteResponse: NoteResponseModel)
}
