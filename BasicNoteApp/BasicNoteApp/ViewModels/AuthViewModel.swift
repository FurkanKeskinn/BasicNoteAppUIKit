//
//  AuthViewModel.swift
//  BasicNoteApp
//
//  Created by Furkan on 26.07.2023.
//

import Foundation

class LoginViewModel: LoginViewModelProtocol {
    
    internal var loginResponseData: AuthResponseData?
    private var serviceLogin = AuthService()
    private var keychainService: KeychainService
    
    init(keychainService: KeychainService = KeychainServiceImpl()) {
        self.serviceLogin = AuthService()
        self.keychainService = keychainService
    }
    
    internal func delegateLogin(delegate: AuthResponseData) {
        self.loginResponseData = delegate
    }
    
    internal func getLoginUserData(email: String, password: String) {
        serviceLogin.loginUser(email: email, password: password) { result in
            switch result {
            case .success(let loginResponse):
                self.loginResponseData?.authData(authResponse: loginResponse)
                self.keychainService.removeAccessToken()
                let token = loginResponse.data.accessToken
                self.keychainService.saveAccessToken(token)
                
            case .failure(let error):
                print(error)
            }
        }
    }
}
