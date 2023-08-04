//
//  UserProtocol.swift
//  BasicNoteApp
//
//  Created by Furkan on 26.07.2023.
//

import Foundation

protocol AllNotesViewModelProtocol {
    func getallNotesData()
    var allNotesResponseData: AllNotesResponseData? {get}
    func delegateAllNotes(delegate: AllNotesResponseData)
}

protocol AllNotesResponseData {
    func allNotesData(allNotesResponse: [NoteDataModel])
}
