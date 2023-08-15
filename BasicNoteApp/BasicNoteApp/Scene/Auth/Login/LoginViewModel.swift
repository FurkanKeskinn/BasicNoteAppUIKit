//
//  LoginViewModel.swift
//  BasicNoteApp
//
//  Created by Furkan on 15.08.2023.
//

import Foundation

protocol LoginViewModelProtocol {
    var reloadData: ((AuthResponseModel) -> ())? {get}
    func getLoginUserData(email: String, password: String, completion: @escaping (Bool) -> Void)
}

class LoginViewModel: LoginViewModelProtocol {
    
    var reloadData: ((AuthResponseModel) -> ())?
    private var serviceLogin = AuthService()
    private var keychainService: KeychainService
    
    init(keychainService: KeychainService = KeychainServiceImpl()) {
        self.serviceLogin = AuthService()
        self.keychainService = keychainService
    }
    
    internal func getLoginUserData(email: String, password: String, completion: @escaping (Bool) -> Void) {
        serviceLogin.loginUser(email: email, password: password) { result in
            switch result {
            case .success(let loginResponse):
                self.reloadData?(loginResponse)
                self.keychainService.removeAccessToken()
                let token = loginResponse.data?.accessToken
                self.keychainService.saveAccessToken(token!)
                completion(true)
                
            case .failure(let error):
                print(error)
                completion(false)
            }
        }
    }
}
