//
//  PasswordUpdateViewModel.swift
//  BasicNoteApp
//
//  Created by Furkan on 15.08.2023.
//

import Foundation

protocol ChangePasswordViewModelProtocol {
    var didSuccessChangePassword: ((Bool) -> ())? {get set}
    func getPasswordUpdateData(password: String, newPassword: String, newPasswordConfirmation: String)
}

class ChangePasswordViewModel: ChangePasswordViewModelProtocol {
    
    internal var didSuccessChangePassword: ((Bool) -> ())?
    
    private var servicePasswordUpdate = UserService()
    
    init(){
        self.servicePasswordUpdate = UserService()
    }
    
    
    func getPasswordUpdateData(password: String, newPassword: String, newPasswordConfirmation: String) {
        servicePasswordUpdate.updatePassword(password: password, newPassword: newPassword, newPasswordConfirmation: newPasswordConfirmation) { result in
            switch result {
            case .success:
                self.didSuccessChangePassword?(true)
            case .failure:
                self.didSuccessChangePassword?(false)
            }
        }
    }
}
