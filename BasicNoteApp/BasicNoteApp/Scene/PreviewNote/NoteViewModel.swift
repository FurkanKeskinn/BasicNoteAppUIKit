//
//  NoteViewModel.swift
//  BasicNoteApp
//
//  Created by Furkan on 15.08.2023.
//

import Foundation

protocol NoteViewModelProtocol {
    func getNote(id: Int)
    var reloadData: ((NoteResponseModel) -> ())? {get set}
}

class NoteViewModel: NoteViewModelProtocol {
    
    private var noteService = NoteService()
    internal var reloadData: ((NoteResponseModel) -> ())?
    
    init() {
        self.noteService = NoteService()
    }
    
    internal func getNote(id: Int) {
        noteService.getNotesDetail(id: id) { result in
            switch result {
            case .success(let noteResponse):
                self.reloadData?(noteResponse)
            case .failure(let error):
                print(error)
            }
        }
    }
}
