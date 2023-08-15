//
//  UserUpdateViewModel.swift
//  BasicNoteApp
//
//  Created by Furkan on 15.08.2023.
//

import Foundation

protocol UserUpdateViewModelProtocol {
    var reloadData: ((UserResponseModel) -> ())? {get}
    func getUserUpdateData(fullName: String, email: String)
}

class UserUpdateViewModel: UserUpdateViewModelProtocol {
    
    internal var reloadData: ((UserResponseModel) -> ())?
    private var serviceUserUpdate = UserService()
    
    init(){
        self.serviceUserUpdate = UserService()
    }
    
    func getUserUpdateData(fullName: String, email: String) {
        serviceUserUpdate.updateUser(fullName: fullName, email: email) { result in
            switch result {
            case .success(let userUpdateResponse):
                self.reloadData?(userUpdateResponse)
            case .failure(let error):
                print(error)
            }
        }
    }
}
