//
//  ViewModel_User.swift
//  DrivUs
//
//  Created by MacBook on 27.05.24.
//

import Foundation

class ViewModel_User: ObservableObject {
    @Published private (set) var model: Model.UserModel
    
    init(_ model: Model.UserModel) {
        self.model = model
    }
    
    var users: [Model.UserModel.User] {
        model.users
    }
    
    var loggedUser: Model.UserModel.User {
        model.loggedUser
    }
    
    var userById: Model.UserModel.User {
        model.userById
    }
    
    func getUserById(_ id: String) -> Model.UserModel.User? {
            return model.getUserById(id)
    }
    
    func setUsers(_ users: [Model.UserModel.User]) {
        model.setUsers(users)
    }
    
    func setLoginUser(_ userId: String) {
        model.setLoginUser(userId)
    }
    
    func setUserById(_ user: Model.UserModel.User) {
        model.setUserByid(user)
    }
    
    func fetchUserById(_ id: String) -> Model.UserModel.User?{
        /*UserService.shared.fetchUserById(byID: id) { [weak self] user in
            DispatchQueue.main.async {
                self?.setUserById(user ?? Model.UserModel.DefaultUser.default)
            }
        }*/
        print("userById: \(userById.name)")
        
        return MatchManager.shared.filterUserById(id, users)
    }
    
    func fetchAllUsers() {
        UserService.shared.fetchAllUsers { [weak self] users in
            DispatchQueue.main.async {
                self?.setUsers(users ?? [])
            }
        }
    }
    
    
}
