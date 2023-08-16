//
//  NoteCreateViewModel.swift
//  BasicNoteApp
//
//  Created by Furkan on 15.08.2023.
//

import Foundation

protocol NoteCreateViewModelProtocol {
    var reloadData: ((NoteResponseModel) -> ())? {get}
    func createNote(title: String, note: String)
}

class NoteCreateViewModel: NoteCreateViewModelProtocol{
    
    private var serviceNoteCreate = NoteService()
    internal var reloadData: ((NoteResponseModel) -> ())?
    
    init(){
        self.serviceNoteCreate = NoteService()
    }
    
    func createNote(title: String, note: String) {
        serviceNoteCreate.createNote(title: title, note: note) { result in
            switch result {
            case .success(let noteCreateResponse):
                self.reloadData?(noteCreateResponse)
            case .failure(let error):
                print(error)
            }
        }
    }
}
