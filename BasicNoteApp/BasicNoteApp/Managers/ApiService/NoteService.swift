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
    
    // MARK: - Detail Note
    func getNotesDetail(id: Int, completion: @escaping (Result<NoteResponseModel, APIError>) -> Void) {
        let note = NoteDetailModel(id: id)
        
        guard let token = keychainService.getAccessToken() else {
            completion(.failure(APIError.failedTogetData))
            return
        }
        
        let headers: HTTPHeaders = ["Authorization": "Bearer \(token)"]
        
        if let noteURL = Constants.API.getNoteURL(noteID: note.id) {
            AF.request(noteURL, method: .get, headers: headers).responseJSON { response in
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
    
    // MARK: - Delete Note
    func deleteNotes(id: Int, completion: @escaping (Result<Void, APIError>) -> Void) {
        let note = NoteDetailModel(id: id)
        
        guard let token = keychainService.getAccessToken() else {
            completion(.failure(APIError.failedTogetData))
            return
        }
        
        let headers: HTTPHeaders = ["Authorization": "Bearer \(token)"]
        
        if let deleteURL = Constants.API.getNoteURL(noteID: note.id) {
            AF.request(deleteURL, method: .delete, headers: headers).response { response in
                switch response.result {
                case .success:
                    if response.response?.statusCode == 204 {
                        completion(.success(()))
                    } else {
                        completion(.failure(APIError.failedTogetData))
                    }
                case .failure(let error):
                    print("Error deleting note: \(error)")
                    completion(.failure(APIError.failedTogetData))
                }
            }
        } else {
            completion(.failure(APIError.failedTogetData))
        }
    }
    
    // MARK: - Create Note
    func createNote(title: String, note: String, completion: @escaping (Result<NoteResponseModel, APIError>) -> Void) {
        
        let note = NoteModel(title: title, note: note)
        
        let parameters: Parameters = [
            "title": note.title,
            "note": note.note
        ]
        
        guard let token = keychainService.getAccessToken() else {
            completion(.failure(APIError.failedTogetData))
            return
        }
        
        let headers: HTTPHeaders = ["Authorization": "Bearer \(token)"]
        
        AF.request(Constants.API.notesURL, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseDecodable(of: NoteResponseModel.self) { response in
            switch response.result {
            case .success(let noteResponse):
                completion(.success(noteResponse))
            case .failure(_):
                completion(.failure(APIError.failedTogetData))
            }
        }
    }
    
    // MARK: - Update Note
    func updateNote(id: Int, title: String, note: String, completion: @escaping (Result<NoteResponseModel, APIError>) -> Void) {
        let note = NoteDataModel(title: title, note: note, id: id)
        let parameters: Parameters = [
            "title": note.title,
            "note": note.note]
        
        guard let token = keychainService.getAccessToken() else {
            completion(.failure(APIError.failedTogetData))
            return
        }
        
        let headers: HTTPHeaders = ["Authorization": "Bearer \(token)"]
        
        if let noteURL = Constants.API.getNoteURL(noteID: note.id) {
            AF.request(noteURL, method: .put, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
                .responseDecodable(of: NoteResponseModel.self) { response in
                    switch response.result {
                    case .success(let noteResponse):
                        completion(.success(noteResponse))
                    case .failure(_):
                        completion(.failure(APIError.failedTogetData))
                    }
                }
        } else {
            completion(.failure(APIError.failedTogetData))
        }
    }
}
