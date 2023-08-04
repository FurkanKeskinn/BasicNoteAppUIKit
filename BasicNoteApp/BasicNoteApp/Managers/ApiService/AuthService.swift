//
//  AuthService.swift
//  BasicNoteApp
//
//  Created by Furkan on 26.07.2023.
//

import Foundation
import Alamofire

class AuthService {
    
    func loginUser(email: String, password: String, completion: @escaping (Result<AuthResponseModel, APIError>) -> Void) {
        
        let login = Login(email: email, password: password)
        
        let parameters: Parameters = [
            "email": login.email,
            "password": login.password
        ]
        
        AF.request(Constants.API.loginURL!, method: .post, parameters: parameters, encoding: JSONEncoding.default).validate().responseDecodable(of: AuthResponseModel.self) { response in
            switch response.result {
            case .success(let authResponse):
                let token = authResponse.data.accessToken
                completion(.success(authResponse))
                
            case .failure(_):
                completion(.failure(APIError.failedTogetData))
            }
        }
    }
}
