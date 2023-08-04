//
//  AuthProtocol.swift
//  BasicNoteApp
//
//  Created by Furkan on 26.07.2023.
//

import Foundation

protocol LoginViewModelProtocol {
    func getLoginUserData(email: String, password: String)
    var loginResponseData: AuthResponseData? {get}
    func delegateLogin(delegate: AuthResponseData)
}

protocol AuthResponseData {
    func authData(authResponse: AuthResponseModel)
}
