//
//  RegisterViewModel.swift
//  BasicNoteApp
//
//  Created by Furkan on 15.08.2023.
//

import Foundation

protocol RegisterViewModelProtocol {
    var reloadData: ((AuthResponseModel) -> ())? {get}
    func getRegisterUserData(fullName: String, email: String, password: String)
}

class RegisterViewModel: RegisterViewModelProtocol {
    
    internal var reloadData: ((AuthResponseModel) -> ())?
    
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
                self.reloadData?(registerResponse)
                self.keychainService.removeAccessToken()
                let token = registerResponse.data?.accessToken
                self.keychainService.saveAccessToken(token!)
                
            case .failure(let error):
                print(error)
            }
        }
    }
}
