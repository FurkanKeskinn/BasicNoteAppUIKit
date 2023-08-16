//
//  NoteUpdateViewModel.swift
//  BasicNoteApp
//
//  Created by Furkan on 15.08.2023.
//

import Foundation

protocol NoteUpdateViewModelProtocol {
    func updateNote(id: Int, title: String, note: String)
    var reloadData: ((NoteResponseModel) -> ())? {get}
}

class NoteUpdateViewModel: NoteUpdateViewModelProtocol{
    var note: NoteDataModel
    private var serviceNoteUpdate = NoteService()
    internal var reloadData: ((NoteResponseModel) -> ())?
    
    init(note: NoteDataModel){
        self.serviceNoteUpdate = NoteService()
        self.note = note
    }
    
    func updateNote(id: Int, title: String, note: String) {
        serviceNoteUpdate.updateNote(id: id, title: title, note: note) { result in
            switch result {
            case .success(let noteUpdateResponse):
                self.reloadData?(noteUpdateResponse)
            case .failure(let error):
                print(error)
            }
        }
    }
}
