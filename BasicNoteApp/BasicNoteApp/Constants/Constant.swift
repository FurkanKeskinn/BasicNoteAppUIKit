//
//  Constant.swift
//  BasicNoteApp
//
//  Created by Furkan on 26.07.2023.
//

import Foundation

struct Constants {
    
    public struct API {
        
        // MARK: - Base
        public static let baseURL = URL(string: "https://basicnoteapp.mobillium.com/")!
        public static let apiURL = URL(string: "\(baseURL)api/")!
        
        // MARK: - Auth
        public static let authURL = URL(string: "\(apiURL)auth/")!
        public static let loginURL = URL(string: "\(authURL)login")
        public static let registerURL = URL(string: "\(authURL)register")
        public static let forgotPasswordURL = URL(string: "\(authURL)forgot-password")
        
        // MARK: - Profile
        
        public static let usersURL = URL(string: "\(apiURL)users/")!
        public static let myProfileURL = URL(string: "\(usersURL)me/")!
        public static let notesPageURL = URL(string: "\(myProfileURL)notes")
        public static let aboutMeURL = URL(string: "\(myProfileURL)me")
        public static let changePasswordURL = URL(string: "\(myProfileURL)password")
        
        // MARK: - Notes
        
        public static let notesURL = URL(string: "\(apiURL)notes/")!
        public static let chosenNoteURL = URL(string: "\(notesURL):note_id")
        
        public static func getNoteURL(noteID: Int) -> URL? {
            return URL(string: "\(API.notesURL)\(noteID)")
        }
    }
}
