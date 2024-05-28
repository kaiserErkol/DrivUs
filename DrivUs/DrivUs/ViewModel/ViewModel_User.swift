//
//  ViewModel_User.swift
//  DrivUs
//
//  Created by MacBook on 27.05.24.
//

import Foundation

class ViewModel_User: ObservableObject {
    @Published private (set) var model = UserModel()
    
    var users: [UserObject] {
        model.users
    }
    
    var currUser: UserObject {
        model.curr_user
    }
    
    func setUsers(users: [UserObject]) {
        model.setUsers(users)
        print("Users loaded: \(users)")
    }
    
    func usersLoaded(_ users: [UserObject]) {
        model.setUsers(users)
    }
    
    
    func getUserById(id: String) -> UserObject {
        for user in users {
            if user.id == id {
                return user
            }
        }
        return StandardObject.default
    }
    
    func fetchUsers() {
        UserService.shared.fetchUsers { [weak self] users in
            DispatchQueue.main.async {
                self?.setUsers(users: users ?? [])
            }
        }
    }
}
