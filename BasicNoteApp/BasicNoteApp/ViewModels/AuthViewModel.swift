//
//  AuthViewModel.swift
//  BasicNoteApp
//
//  Created by Furkan on 26.07.2023.
//

import Foundation

// MARK: - Login
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
    
    internal func getLoginUserData(email: String, password: String, completion: @escaping (Bool) -> Void) {
        serviceLogin.loginUser(email: email, password: password) { result in
            switch result {
            case .success(let loginResponse):
                self.loginResponseData?.authData(authResponse: loginResponse)
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

// MARK: - Register
class RegisterViewModel: RegisterViewModelProtocol {
    
    internal var registerResponseData: AuthResponseData?
    private var serviceRegister = AuthService()
    private var keychainService: KeychainService
    
    init(keychainService: KeychainService = KeychainServiceImpl()) {
        self.serviceRegister = AuthService()
        self.keychainService = keychainService
    }
    
    internal func delegateRegister(delegate: AuthResponseData) {
        self.registerResponseData = delegate
    }
    
    internal func getRegisterUserData(fullName: String, email: String, password: String) {
        serviceRegister.registerUser(fullName: fullName, email: email, password: password) { result in
            switch result {
            case .success(let registerResponse):
                self.registerResponseData?.authData(authResponse: registerResponse)
                self.keychainService.removeAccessToken()
                let token = registerResponse.data?.accessToken
                self.keychainService.saveAccessToken(token!)
                
            case .failure(let error):
                print(error)
            }
        }
    }
}

// MARK: - Reset Password
class ResetPasswordViewModel: ResetPasswordViewModelProtocol {
    
    internal var resetPasswordResponseData: AuthResponseData?
    private var serviceResetPassword = AuthService()
    
    init() {
        self.serviceResetPassword = AuthService()
    }
    
    internal func delegateResetPassword(delegate: AuthResponseData) {
        self.resetPasswordResponseData = delegate
    }
    
    internal func getResetPasswordUserData(email: String) {
        serviceResetPassword.resetPassword(email: email) { result in
            switch result {
            case .success(let resetPasswordResponse):
                self.resetPasswordResponseData?.authData(authResponse: resetPasswordResponse)
                
            case .failure(let error):
                print(error)
            }
        }
    }
}
