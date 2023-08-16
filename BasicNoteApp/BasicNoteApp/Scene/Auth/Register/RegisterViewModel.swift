//
//  RegisterViewModel.swift
//  BasicNoteApp
//
//  Created by Furkan on 15.08.2023.
//

import Foundation

protocol RegisterViewModelProtocol {
    var didSuccessRegister: ((Bool) -> ())? {get set}
    func getRegisterUserData(fullName: String, email: String, password: String)
}

class RegisterViewModel: RegisterViewModelProtocol {
    
    internal var didSuccessRegister: ((Bool) -> ())?
    
    private var serviceRegister = AuthService()
    private var keychainService: KeychainService
    
    init(keychainService: KeychainService = KeychainServiceImpl()) {
        self.serviceRegister = AuthService()
        self.keychainService = keychainService
    }
    
    internal func getRegisterUserData(fullName: String, email: String, password: String) {
        serviceRegister.registerUser(fullName: fullName, email: email, password: password) { result in
            switch result {
            case .success(let registerResponse):
                self.didSuccessRegister?(true)
                self.keychainService.removeAccessToken()
                let token = registerResponse.data?.accessToken
                self.keychainService.saveAccessToken(token!)
                
            case .failure:
                self.didSuccessRegister?(false)
            }
        }
    }
}
