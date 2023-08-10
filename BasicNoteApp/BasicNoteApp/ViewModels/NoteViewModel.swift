//
//  NoteViewModel.swift
//  BasicNoteApp
//
//  Created by Furkan on 27.07.2023.
//

import Foundation

// MARK: - Detail Note
class NoteViewModel: NoteViewModelProtocol {
    
    private var noteService = NoteService()
    internal var noteDetailResponseData: NoteResponseData?
    
    init() {
        self.noteService = NoteService()
    }
    
    internal func delegateNote(delegate: NoteResponseData) {
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

// MARK: - Delete Note
class NoteDeleteViewModel: NoteDeleteViewModelProtocol {
    
    private var noteService = NoteService()
    internal var noteDeleteResponseData: NoteResponseData?
    
    init() {
        self.noteService = NoteService()
    }
    
    internal func delegateNoteDelete(delegate: NoteResponseData) {
        self.noteDeleteResponseData = delegate
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

// MARK: - Create Note
class NoteCreateViewModel: NoteCreateViewModelProtocol{
    
    private var serviceNoteCreate = NoteService()
    
    internal var noteCreateResponseData: NoteResponseData?
    
    init(){
        self.serviceNoteCreate = NoteService()
    }
    
    func delegateNoteCreate(delegate: NoteResponseData) {
        self.noteCreateResponseData = delegate
    }
    func createNote(title: String, note: String) {
        serviceNoteCreate.createNote(title: title, note: note) { result in
            switch result {
            case .success(let noteCreateResponse):
                self.noteCreateResponseData?.noteData(noteResponse: noteCreateResponse)
            case .failure(let error):
                print(error)
            }
        }
    }
}

// MARK: - Update Note
class NoteUpdateViewModel: NoteUpdateViewModelProtocol{
    
    private var serviceNoteUpdate = NoteService()
    
    internal var noteUpdateResponseData: NoteResponseData?
    
    init(){
        self.serviceNoteUpdate = NoteService()
    }
    
    func delegateNoteUpdate(delegate: NoteResponseData) {
        self.noteUpdateResponseData = delegate
    }
    func updateNote(id: Int, title: String, note: String) {
        serviceNoteUpdate.updateNote(id: id, title: title, note: note) { result in
            switch result {
            case .success(let noteUpdateResponse):
                self.noteUpdateResponseData?.noteData(noteResponse: noteUpdateResponse)
            case .failure(let error):
                print(error)
            }
        }
    }
}
