//
//  UserModel.swift
//  DrivUs
//
//  Created by MacBook on 27.05.24.
//

import Foundation

struct UserModel {
    private (set) var users = [UserObject]()
    private (set) var curr_user = StandardObject.default
    
    mutating func setUsers(_ loadedUsers: [UserObject]) {
        users = loadedUsers
    }
    
    
    
    mutating func setCurrUser(_ userId: String) {
        print("in set curr user 1", userId)
        print("users:",users)
        for user in users {
            print("in set curr user 2")
            if userId == user.id {
                curr_user = user
                print("cuur user in modl: ",curr_user)
            }
        }
    }
}

struct UserObject: Codable, Identifiable, Hashable {
    var id: String
    var name: String
    var pos_longitude: Double
    var pos_latitude: Double
    var driver: Bool
}
/*
static var `simulation`: UserObject {
    return UserObject(id: 0, name: "Simulation", pos_longitude: 0.0, pos_latitude: 0.0, driver: false)
}
 */

struct UserDTO: Codable {
    var users: [UserObject]
}


struct StandardObject {
    static var `default`: UserObject {
        return UserObject(id: "-1", name: "No User Found", pos_longitude: 0.0, pos_latitude: 0.0, driver: false)
    }
}

