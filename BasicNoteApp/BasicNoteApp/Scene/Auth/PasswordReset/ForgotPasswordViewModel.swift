//
//  ResetPasswordViewModel.swift
//  BasicNoteApp
//
//  Created by Furkan on 15.08.2023.
//

import Foundation

protocol ResetPasswordViewModelProtocol {
    var didSuccessForgotPassword: ((Bool) -> ())? {get set}
    func getResetPasswordUserData(email: String)
}

class ResetPasswordViewModel: ResetPasswordViewModelProtocol {
    
    var didSuccessForgotPassword: ((Bool) -> ())?
    private var serviceResetPassword = AuthService()
    
    init() {
        self.serviceResetPassword = AuthService()
    }
    
    internal func getResetPasswordUserData(email: String) {
        serviceResetPassword.resetPassword(email: email) { result in
            switch result {
            case .success:
                self.didSuccessForgotPassword?(true)
            case .failure:
                self.didSuccessForgotPassword?(false)
            }
        }
    }
}
