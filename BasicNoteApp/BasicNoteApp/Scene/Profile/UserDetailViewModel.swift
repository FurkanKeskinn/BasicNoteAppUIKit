//
//  UserDetailViewModel.swift
//  BasicNoteApp
//
//  Created by Furkan on 15.08.2023.
//

import Foundation

protocol UserDetailViewModelProtocol {
    func getUserDetailData()
    var reloadData: ((UserResponseModel) -> ())? {get set}
}

class UserDetailViewModel: UserDetailViewModelProtocol {
    
    private var userService = UserService()
    internal var reloadData: ((UserResponseModel) -> ())?
    
    init() {
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
}
