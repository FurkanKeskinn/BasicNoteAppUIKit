//
//  UserViewModel.swift
//  BasicNoteApp
//
//  Created by Furkan on 26.07.2023.
//

import Foundation

class AllNotesViewModel : AllNotesViewModelProtocol {
    
    private var serviceAllNotes = UserService()
    internal var allNotesResponseData: AllNotesResponseData?
    
    init() {
        self.serviceAllNotes = UserService()
    }
    
    internal func delegateAllNotes(delegate: AllNotesResponseData) {
        self.allNotesResponseData = delegate
    }
    
    internal func getallNotesData() {
        serviceAllNotes.userAllNotes { result in
            switch result {
            case .success(let notesResponse):
                self.allNotesResponseData?.allNotesData(allNotesResponse: notesResponse)
            case .failure(let error):
                print(error)
            }
        }
    }
}
