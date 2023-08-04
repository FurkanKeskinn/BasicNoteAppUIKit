//
//  NoteProtocol.swift
//  BasicNoteApp
//
//  Created by Furkan on 27.07.2023.
//

import Foundation

protocol NoteViewModelProtocol {
    func getNote(id: Int)
    var noteDetailResponseData: NoteDetailData? {get}
    func delegateNote(delegate: NoteDetailData)
}

protocol NoteDetailData {
    func noteData(noteResponse: NoteResponseModel)
}
