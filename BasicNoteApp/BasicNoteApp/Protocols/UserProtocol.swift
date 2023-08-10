//
//  UserProtocol.swift
//  BasicNoteApp
//
//  Created by Furkan on 26.07.2023.
//

import Foundation

// MARK: - All Notes
protocol AllNotesViewModelProtocol {
    func getallNotesData()
    var allNotesResponseData: AllNotesResponseData? {get}
    func delegateAllNotes(delegate: AllNotesResponseData)
}

protocol AllNotesResponseData {
    func allNotesData(allNotesResponse: [NoteDataModel])
}

// MARK: - Detail User
protocol UserDetailViewModelProtocol {
    func getUserDetailData()
    var userDetailResponseData: UserResponseData? {get}
    func delegateUserDetail(delegate: UserResponseData)
}

// MARK: - Update USer
protocol UserUpdateViewModelProtocol {
    func getUserUpdateData(fullName: String, email: String)
    var userUpdateResponseData: UserResponseData? {get}
    func delegateUserUpdate(delegate: UserResponseData)
}

protocol UserResponseData {
    func userData(userResponse: UserResponseModel)
}

// MARK: - Password Update
protocol PasswordUpdateViewModelProtocol {
    func getPasswordUpdateData(password: String, newPassword: String, newPasswordConfirmation: String)
    var passwordUpdateResponseData: PasswordResponseData? {get}
    func delegateUserPassword(delegate: PasswordResponseData)
}

protocol PasswordResponseData {
    func passwordData(passwordResponse: ChangePasswordResponseModel)
}
