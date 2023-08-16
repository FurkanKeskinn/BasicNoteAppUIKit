//
//  NoteCreateViewModel.swift
//  BasicNoteApp
//
//  Created by Furkan on 15.08.2023.
//

import Foundation

protocol AddNoteViewModelProtocol {
    var didSuccessAddNote: ((Bool) -> ())? {get set}
    func createNote(title: String, note: String)
}

class AddNoteViewModel: AddNoteViewModelProtocol {
    
    private var serviceNoteCreate = NoteService()
    internal var didSuccessAddNote: ((Bool) -> ())?
    
    init(){
        self.serviceNoteCreate = NoteService()
    }
    
    func createNote(title: String, note: String) {
        serviceNoteCreate.createNote(title: title, note: note) { result in
            switch result {
            case .success:
                self.didSuccessAddNote?(true)
            case .failure:
                self.didSuccessAddNote?(false)
            }
        }
    }
}
