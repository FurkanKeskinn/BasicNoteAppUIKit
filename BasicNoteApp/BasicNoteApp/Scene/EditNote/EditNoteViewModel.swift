//
//  NoteUpdateViewModel.swift
//  BasicNoteApp
//
//  Created by Furkan on 15.08.2023.
//

import Foundation

protocol EditNoteViewModelProtocol {
    var note: NoteDataModel? {get}
    func updateNote(title: String, noteText: String)
    var didSuccessUpdateNote: ((Bool) -> ())? {get set}
}

class EditNoteViewModel: EditNoteViewModelProtocol{
    internal var note: NoteDataModel?
    private var serviceNoteUpdate = NoteService()
    internal var didSuccessUpdateNote: ((Bool) -> ())?
    
    init(note: NoteDataModel?) {
        self.serviceNoteUpdate = NoteService()
        self.note = note
    }
    
    func updateNote(title: String, noteText: String) {
        guard let note = self.note else {return}
        serviceNoteUpdate.updateNote(id: note.id, title: title, note: noteText) { result in
            switch result {
            case .success:
                self.didSuccessUpdateNote?(true)
            case .failure:
                self.didSuccessUpdateNote?(false)
            }
        }
    }
}
