//
//  LocalService.swift
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

class KeychainServiceImpl: KeychainService {
    private let accessTokenKey = "access_Token"
    
    func saveAccessToken(_ token: String) {
        
        if let data = token.data(using: .utf8) {
            let query: [String: Any] = [
                kSecClass as String: kSecClassGenericPassword,
                kSecAttrAccount as String: accessTokenKey,
                kSecValueData as String: data
            ]
            SecItemDelete(query as CFDictionary)
            SecItemAdd(query as CFDictionary, nil)
        }
    }
    
    func getAccessToken() -> String? {
        
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: accessTokenKey,
            kSecMatchLimit as String: kSecMatchLimitOne,
            kSecReturnData as String: true
        ]
        var item: CFTypeRef?
        let status = SecItemCopyMatching(query as CFDictionary, &item)
        guard status == errSecSuccess,
              let keyData = item as? Data,
              let token = String(data: keyData, encoding: .utf8) else {
            return nil
        }
        return token
    }
    
    func removeAccessToken() {
        
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: accessTokenKey
        ]
        SecItemDelete(query as CFDictionary)
    }
}
