//
//  LocalProtocol.swift
//  BasicNoteApp
//
//  Created by Furkan on 26.07.2023.
//

import Foundation

protocol KeychainService {
    func saveAccessToken(_ token: String)
    func getAccessToken() -> String?
    func removeAccessToken()
}
