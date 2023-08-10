//
//  UserService.swift
//  BasicNoteApp
//
//  Created by Furkan on 2.08.2023.
//

import Foundation
import Alamofire

class UserService {
    
    private var keychainService: KeychainService
    
    init(keychainService: KeychainService = KeychainServiceImpl()) {
        self.keychainService = keychainService
    }
    // MARK: - All Notes
    func userAllNotes(completion: @escaping (Result<[NoteDataModel], APIError>) -> Void) {
        
        guard let token = keychainService.getAccessToken() else {
            completion(.failure(APIError.failedTogetData))
            return
        }
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(token)"
        ]
        
        AF.request(Constants.API.notesPageURL!, method: .get, headers: headers).responseJSON { response in
            switch response.result {
            case .success(let jsonData):
                do {
                    guard let jsonDictionary = jsonData as? [String: Any],
                          let dataDictionary = jsonDictionary["data"] as? [String: Any],
                          let dataArray = dataDictionary["data"] as? [[String: Any]] else {
                        throw APIError.failedTogetData
                    }
                    let jsonData = try JSONSerialization.data(withJSONObject: dataArray)
                    let decoder = JSONDecoder()
                    let userNotesResponse = try decoder.decode([NoteDataModel].self, from: jsonData)
                    completion(.success(userNotesResponse))
                } catch {
                    completion(.failure(APIError.failedTogetData))
                }
            case .failure(_):
                completion(.failure(APIError.failedTogetData))
            }
        }
    }
    
    // MARK: - Detail User
    func getUserDetail(completion: @escaping (Result<UserResponseModel, APIError>) -> Void) {
        guard let token = keychainService.getAccessToken() else {
            completion(.failure(APIError.failedTogetData))
            return
        }
        
        let headers: HTTPHeaders = ["Authorization": "Bearer \(token)"]
        
        AF.request(Constants.API.aboutMeURL!, method: .get, headers: headers).responseJSON { response in
            switch response.result {
            case .success:
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let userResponse = try decoder.decode(UserResponseModel.self, from: response.data ?? Data())
                    completion(.success(userResponse))
                } catch {
                    print("JSON Decoding Error: \(error)")
                    completion(.failure(APIError.failedTogetData))
                }
            case .failure(let error):
                print("API Request Error: \(error)")
                completion(.failure(APIError.failedTogetData))
            }
        }
    }
    
    // MARK: - Update User
    func updateUser(fullName: String, email: String, completion: @escaping (Result<UserResponseModel, APIError>) -> Void) {
        let user = UserInfermationModel(fullName: fullName, email: email)
        let parameters: Parameters = [
            "full_name": user.fullName,
            "email": user.email]
        
        guard let token = keychainService.getAccessToken() else {
            completion(.failure(APIError.failedTogetData))
            return
        }
        
        let headers: HTTPHeaders = ["Authorization": "Bearer \(token)"]
        
        AF.request(Constants.API.aboutMeURL!, method: .put, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
            .responseDecodable(of: UserResponseModel.self) { response in
                switch response.result {
                case .success(let userResponse):
                    completion(.success(userResponse))
                case .failure(_):
                    completion(.failure(APIError.failedTogetData))
                }
            }
    }
    
    // MARK: - Update Password
    func updatePassword(password: String, newPassword: String, newPasswordConfirmation: String, completion: @escaping (Result<ChangePasswordResponseModel, APIError>) -> Void) {
        let password = ChangePasswordModel(password: password, newPassword: newPassword, newPasswordConfirmation: newPasswordConfirmation)
        let parameters: Parameters = [
            "password": password.password,
            "new_password": password.newPassword,
            "new_password_confirmation": password.newPasswordConfirmation,
        ]
        
        guard let token = keychainService.getAccessToken() else {
            completion(.failure(APIError.failedTogetData))
            return
        }
        
        let headers: HTTPHeaders = ["Authorization": "Bearer \(token)"]
        
        AF.request(Constants.API.changePasswordURL!, method: .put, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
            .responseDecodable(of: ChangePasswordResponseModel.self) { response in
                switch response.result {
                case .success(let passwordResponse):
                    completion(.success(passwordResponse))
                case .failure(_):
                    completion(.failure(APIError.failedTogetData))
                }
            }
    }
}

