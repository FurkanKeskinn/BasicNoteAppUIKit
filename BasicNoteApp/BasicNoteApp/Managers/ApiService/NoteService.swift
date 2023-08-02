//
//  NoteService.swift
//  BasicNoteApp
//
//  Created by Furkan on 27.07.2023.
//

import Foundation
import Alamofire

class NoteService {
    
    private var keychainService: KeychainService
    
    init(keychainService: KeychainService = KeychainServiceImpl()) {
        self.keychainService = keychainService
    }
    
    func getNotesDetail(id: Int, completion: @escaping (Result<NoteResponseModel, APIError>) -> Void) {
        let note = NoteDetailModel(id: id)
        let parameters: Parameters = ["note_id": note.id]
        
        guard let token = keychainService.getAccessToken() else {
            completion(.failure(APIError.failedTogetData))
            return
        }
        
        let headers: HTTPHeaders = ["Authorization": "Bearer \(token)"]
        
        if let noteURL = Constants.API.getNoteURL(noteID: note.id) {
            AF.request(noteURL, method: .get, parameters: parameters, headers: headers).responseJSON { response in
                switch response.result {
                case .success(_):
                    do {
                        let decoder = JSONDecoder()
                        decoder.keyDecodingStrategy = .convertFromSnakeCase
                        let noteDetailResponse = try decoder.decode(NoteResponseModel.self, from: response.data ?? Data())
                        completion(.success(noteDetailResponse))
                    } catch {
                        completion(.failure(APIError.failedTogetData))
                    }
                case .failure(_):
                    completion(.failure(APIError.failedTogetData))
                }
            }
        } else {
            completion(.failure(APIError.failedTogetData))
        }
    }
}
