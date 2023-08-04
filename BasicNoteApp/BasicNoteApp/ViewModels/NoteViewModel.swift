//
//  NoteViewModel.swift
//  BasicNoteApp
//
//  Created by Furkan on 27.07.2023.
//

import Foundation

class NoteViewModel: NoteViewModelProtocol {
    
    private var noteService = NoteService()
    internal var noteDetailResponseData: NoteDetailData?
    
    init() {
        self.noteService = NoteService()
    }
    
    internal func delegateNote(delegate: NoteDetailData) {
        self.noteDetailResponseData = delegate
    }
    internal func getNote(id: Int) {
        noteService.getNotesDetail(id: id) { result in
            switch result {
            case .success(let noteResponse):
                self.noteDetailResponseData?.noteData(noteResponse: noteResponse)
            case .failure(let error):
                print(error)
            }
        }
    }
}
