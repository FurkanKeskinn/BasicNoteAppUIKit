//
//  NoteUpdateViewModel.swift
//  BasicNoteApp
//
//  Created by Furkan on 15.08.2023.
//

import Foundation

protocol EditNoteViewModelProtocol {
    var id : Int? { get set }
    func updateNote(id: Int, title: String, note: String)
    var didSuccessUpdateNote: ((Bool) -> ())? {get set}
}

class EditNoteViewModel: EditNoteViewModelProtocol{
    var id : Int?
    private var serviceNoteUpdate = NoteService()
    internal var didSuccessUpdateNote: ((Bool) -> ())?
    
    init(){
        self.serviceNoteUpdate = NoteService()
        self.id = Int()
    }
    
    func updateNote(id: Int, title: String, note: String) {
        serviceNoteUpdate.updateNote(id: id, title: title, note: note) { result in
            switch result {
            case .success:
                self.didSuccessUpdateNote?(true)
            case .failure:
                self.didSuccessUpdateNote?(false)
            }
        }
    }
}
