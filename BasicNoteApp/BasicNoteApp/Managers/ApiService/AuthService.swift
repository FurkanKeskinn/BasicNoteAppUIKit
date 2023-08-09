//
//  AuthService.swift
//  BasicNoteApp
//
//  Created by Furkan on 26.07.2023.
//

import Foundation
import Alamofire

class AuthService {
    
    // MARK: - Login
    func loginUser(email: String, password: String, completion: @escaping (Result<AuthResponseModel, APIError>) -> Void) {
        
        let login = Login(email: email, password: password)
        
        let parameters: Parameters = [
            "email": login.email,
            "password": login.password
        ]
        
        AF.request(Constants.API.loginURL!, method: .post, parameters: parameters, encoding: JSONEncoding.default).validate().responseDecodable(of: AuthResponseModel.self) { response in
            switch response.result {
            case .success(let authResponse):
                completion(.success(authResponse))
                
            case .failure(_):
                completion(.failure(APIError.failedTogetData))
            }
        }
    }
    
    // MARK: - Register
    func registerUser(fullName: String, email: String, password: String, completion: @escaping (Result<AuthResponseModel, APIError>) -> Void) {
        
        let register = Register(fullName: fullName, email: email, password: password)
        
        let parameters: Parameters = [
            "full_name": register.password,
            "email": register.email,
            "password": register.password
        ]
        
        AF.request(Constants.API.registerURL!, method: .post, parameters: parameters, encoding: JSONEncoding.default).validate().responseDecodable(of: AuthResponseModel.self) { response in
            switch response.result {
            case .success(let authResponse):
                completion(.success(authResponse))
                
            case .failure(_):
                completion(.failure(APIError.failedTogetData))
            }
        }
    }
    
    // MARK: - Reset Password
    func resetPassword(email: String, completion: @escaping (Result<AuthResponseModel, APIError>) -> Void) {
        
        let resetPassword = ForgotPassword(email: email)
        
        let parameters: Parameters = [
            "email": resetPassword.email
        ]
        
        AF.request(Constants.API.forgotPasswordURL!, method: .post, parameters: parameters, encoding: JSONEncoding.default).validate().responseDecodable(of: AuthResponseModel.self) { response in
            switch response.result {
            case .success(let authResponse):
                completion(.success(authResponse))
                
            case .failure(_):
                completion(.failure(APIError.failedTogetData))
            }
        }
    }
}
