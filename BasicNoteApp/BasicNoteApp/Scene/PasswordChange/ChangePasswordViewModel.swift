//
//  PasswordUpdateViewModel.swift
//  BasicNoteApp
//
//  Created by Furkan on 15.08.2023.
//

import Foundation

protocol PasswordUpdateViewModelProtocol {
    var reloadData: ((ChangePasswordResponseModel) -> ())? {get}
    func getPasswordUpdateData(password: String, newPassword: String, newPasswordConfirmation: String)
}

class PasswordUpdateViewModel: PasswordUpdateViewModelProtocol {
    
    internal var reloadData: ((ChangePasswordResponseModel) -> ())?
    
    private var servicePasswordUpdate = UserService()
    
    init(){
        self.servicePasswordUpdate = UserService()
    }
    
    
    func getPasswordUpdateData(password: String, newPassword: String, newPasswordConfirmation: String) {
        servicePasswordUpdate.updatePassword(password: password, newPassword: newPassword, newPasswordConfirmation: newPasswordConfirmation) { result in
            switch result {
            case .success(let passwordUpdateResponse):
                self.reloadData?(passwordUpdateResponse)
            case .failure(let error):
                print(error)
            }
        }
    }
}
