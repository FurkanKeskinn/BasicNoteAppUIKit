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
    
}

