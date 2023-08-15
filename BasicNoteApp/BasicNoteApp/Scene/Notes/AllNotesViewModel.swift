//
//  AllNotesViewModel.swift
//  BasicNoteApp
//
//  Created by Furkan on 15.08.2023.
//

import Foundation

protocol AllNotesViewModelProtocol {
    var reloadData: (([NoteDataModel]) -> ())? {get}
    func getallNotesData()
}

class AllNotesViewModel: AllNotesViewModelProtocol {
    
    private var serviceAllNotes = UserService()
    internal var reloadData: (([NoteDataModel]) -> ())? // bos closure
    
    init() {
        self.serviceAllNotes = UserService()
    }
    
    internal func getallNotesData() {
        serviceAllNotes.userAllNotes { result in
            switch result {
            case .success(let notesResponse):
                //self.allNotesResponseData?.allNotesData(allNotesResponse: notesResponse)
                self.reloadData?(notesResponse)
            case .failure(let error):
                print(error)
            }
        }
    }
}
