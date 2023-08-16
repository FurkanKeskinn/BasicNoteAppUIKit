//
//  NoteDeleteViewModel.swift
//  BasicNoteApp
//
//  Created by Furkan on 15.08.2023.
//

import Foundation


protocol NotesViewModelProtocol {
    var reloadData: (([NoteDataModel]) -> ())? {get set}
    func getallNotesData()
    func deleteNote(id: Int, completion: @escaping (Result<Void, APIError>) -> Void)
}

class NotesViewModel: NotesViewModelProtocol {
    
    private var serviceAllNotes = UserService()
    private var noteService = NoteService()
    internal var reloadData: (([NoteDataModel]) -> ())?
    
    init() {
        self.serviceAllNotes = UserService()
        self.noteService = NoteService()
    }
    
    internal func getallNotesData() {
        serviceAllNotes.userAllNotes { result in
            switch result {
            case .success(let notesResponse):
                self.reloadData?(notesResponse)
            case .failure(let error):
                print(error)
            }
        }
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
