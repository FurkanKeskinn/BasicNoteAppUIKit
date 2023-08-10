//
//  UserViewModel.swift
//  BasicNoteApp
//
//  Created by Furkan on 26.07.2023.
//

import Foundation

class AllNotesViewModel: AllNotesViewModelProtocol {
    
    private var serviceAllNotes = UserService()
    internal var allNotesResponseData: AllNotesResponseData?
    
    init() {
        self.serviceAllNotes = UserService()
    }
    
    internal func delegateAllNotes(delegate: AllNotesResponseData) {
        self.allNotesResponseData = delegate
    }
    
    internal func getallNotesData() {
        serviceAllNotes.userAllNotes { result in
            switch result {
            case .success(let notesResponse):
                self.allNotesResponseData?.allNotesData(allNotesResponse: notesResponse)
            case .failure(let error):
                print(error)
            }
        }
    }
}

// MARK: - Detail User
class UserDetailViewModel: UserDetailViewModelProtocol {
    
    private var userService = UserService()
    internal var userDetailResponseData: UserResponseData?
    
    init() {
        self.userService = UserService()
    }
    
    internal func delegateUserDetail(delegate: UserResponseData) {
        self.userDetailResponseData = delegate
    }
    internal func getUserDetailData() {
        userService.getUserDetail { result in
            switch result {
            case .success(let userResponse):
                self.userDetailResponseData?.userData(userResponse: userResponse)
            case .failure(let error):
                print(error)
            }
        }
    }
}

// MARK: - Update User
class UserUpdateViewModel: UserUpdateViewModelProtocol {
    
    private var serviceUserUpdate = UserService()
    
    internal var userUpdateResponseData: UserResponseData?
    
    init(){
        self.serviceUserUpdate = UserService()
    }
    
    func delegateUserUpdate(delegate: UserResponseData) {
        self.userUpdateResponseData = delegate
    }
    func getUserUpdateData(fullName: String, email: String) {
        serviceUserUpdate.updateUser(fullName: fullName, email: email) { result in
            switch result {
            case .success(let userUpdateResponse):
                self.userUpdateResponseData?.userData(userResponse: userUpdateResponse)
            case .failure(let error):
                print(error)
            }
        }
    }
}

// MARK: - Update Password
class PasswordUpdateViewModel: PasswordUpdateViewModelProtocol {
    
    private var servicePasswordUpdate = UserService()
    
    internal var passwordUpdateResponseData: PasswordResponseData?
    
    init(){
        self.servicePasswordUpdate = UserService()
    }
    
    func delegateUserPassword(delegate: PasswordResponseData) {
        self.passwordUpdateResponseData = delegate
    }
    func getPasswordUpdateData(password: String, newPassword: String, newPasswordConfirmation: String) {
        servicePasswordUpdate.updatePassword(password: password, newPassword: newPassword, newPasswordConfirmation: newPasswordConfirmation) { result in
            switch result {
            case .success(let passwordUpdateResponse):
                self.passwordUpdateResponseData?.passwordData(passwordResponse: passwordUpdateResponse)
            case .failure(let error):
                print(error)
            }
        }
    }
}
