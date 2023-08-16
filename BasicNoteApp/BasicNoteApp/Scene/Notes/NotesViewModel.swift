//
//  NoteDeleteViewModel.swift
//  BasicNoteApp
//
//  Created by Furkan on 15.08.2023.
//

import Foundation

protocol NoteDeleteViewModelProtocol {
    func deleteNote(id: Int, completion: @escaping (Result<Void, APIError>) -> Void)
}

class NoteDeleteViewModel: NoteDeleteViewModelProtocol {
    
    private var noteService = NoteService()
    
    init() {
        self.noteService = NoteService()
    }
    
    internal func deleteNote(id: Int, completion: @escaping (Result<Void, APIError>) -> Void) {
        noteService.deleteNotes(id: id) { result in
            switch result {
            case .success:
                completion(.success(()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
