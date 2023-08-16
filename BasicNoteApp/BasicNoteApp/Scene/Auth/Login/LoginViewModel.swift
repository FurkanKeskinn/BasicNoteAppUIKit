//
//  LoginViewModel.swift
//  BasicNoteApp
//
//  Created by Furkan on 15.08.2023.
//

import Foundation

protocol LoginViewModelProtocol {
    var didSuccessLogin: ((Bool) -> ())? {get set}
    func getLoginUserData(email: String, password: String)
}

class LoginViewModel: LoginViewModelProtocol {
    
    var reloadData: ((AuthResponseModel) -> ())?
    private var serviceLogin = AuthService()
    private var keychainService: KeychainService
    var didSuccessLogin: ((Bool) -> ())?
    
    init(keychainService: KeychainService = KeychainServiceImpl()) {
        self.serviceLogin = AuthService()
        self.keychainService = keychainService
    }
    
    internal func getLoginUserData(email: String, password: String) {
        serviceLogin.loginUser(email: email, password: password) { result in
            switch result {
            case .success(let loginResponse):
                self.didSuccessLogin?(true)
                self.keychainService.removeAccessToken()
                let token = loginResponse.data?.accessToken
                self.keychainService.saveAccessToken(token!)
                
            case .failure:
                self.didSuccessLogin?(false)
            }
        }
    }
}
