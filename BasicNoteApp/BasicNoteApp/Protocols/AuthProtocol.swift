//
//  AuthProtocol.swift
//  BasicNoteApp
//
//  Created by Furkan on 26.07.2023.
//

import Foundation

// MARK: - Login
protocol LoginViewModelProtocol {
    func getLoginUserData(email: String, password: String)
    var loginResponseData: AuthResponseData? {get}
    func delegateLogin(delegate: AuthResponseData)
}

protocol AuthResponseData {
    func authData(authResponse: AuthResponseModel)
}

// MARK: - Register
protocol RegisterViewModelProtocol {
    func getRegisterUserData(fullName: String, email: String, password: String)
    var registerResponseData: AuthResponseData? {get}
    func delegateRegister(delegate: AuthResponseData)
}

// MARK: - Reset Password
protocol ResetPasswordViewModelProtocol {
    func getResetPasswordUserData(email: String)
    var resetPasswordResponseData: AuthResponseData? {get}
    func delegateResetPassword(delegate: AuthResponseData)
}
