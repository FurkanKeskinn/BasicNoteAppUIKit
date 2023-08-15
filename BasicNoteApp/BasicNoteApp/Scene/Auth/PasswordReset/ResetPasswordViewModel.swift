//
//  ResetPasswordViewModel.swift
//  BasicNoteApp
//
//  Created by Furkan on 15.08.2023.
//

import Foundation

protocol ResetPasswordViewModelProtocol {
    var reloadData: ((AuthResponseModel) -> ())? {get}
    func getResetPasswordUserData(email: String)
}

class ResetPasswordViewModel: ResetPasswordViewModelProtocol {
    
    var reloadData: ((AuthResponseModel) -> ())?
    private var serviceResetPassword = AuthService()
    
    init() {
        self.serviceResetPassword = AuthService()
    }
    
    internal func getResetPasswordUserData(email: String) {
        serviceResetPassword.resetPassword(email: email) { result in
            switch result {
            case .success(let resetPasswordResponse):
                self.reloadData?(resetPasswordResponse)
            case .failure(let error):
                print(error)
            }
        }
    }
}
