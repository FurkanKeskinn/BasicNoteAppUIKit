//
//  UserUpdateViewModel.swift
//  BasicNoteApp
//
//  Created by Furkan on 15.08.2023.
//

import Foundation

protocol UserUpdateViewModelProtocol {
    var didSuccessUpdate: ((Bool) -> ())? {get set}
    var reloadData: ((UserResponseModel) -> ())? {get set}
    func getUserUpdateData(fullName: String, email: String)
    func getUserDetailData()
}

class UserUpdateViewModel: UserUpdateViewModelProtocol {
    
    internal var didSuccessUpdate: ((Bool) -> ())?
    internal var reloadData: ((UserResponseModel) -> ())?
    private var userService = UserService()
    
    init(){
        self.userService = UserService()
    }
    
    internal func getUserDetailData() {
        userService.getUserDetail { result in
            switch result {
            case .success(let userResponse):
                self.reloadData?(userResponse)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func getUserUpdateData(fullName: String, email: String) {
        userService.updateUser(fullName: fullName, email: email) { result in
            switch result {
            case .success:
                self.didSuccessUpdate?(true)
            case .failure:
                self.didSuccessUpdate?(false)
            }
        }
    }
}
