//
//  Model.swift
//  DrivUs
//
//  Created by MacBook on 07.06.24.
//

import Foundation

struct Model {
    struct UserModel {
        struct User: Codable, Identifiable, Hashable {
            var id: String
            var age: Int
            var wohnort: String
            var zitat: String
            var pictureURL: String
            var name: String
            var pos_longitude: Double
            var pos_latitude: Double
            var driver: Bool
        }
        
        private (set) var users = [User]()
        private (set) var loggedUser = DefaultUser.default
        private (set) var userById = DefaultUser.default
        
        mutating func setUsers(_ loadedUsers: [User]) {
            users = loadedUsers
        }
        
        func getUserById(_ id: String) -> User? {
                return users.first { $0.id == id }
        }
        
        mutating func setLoginUser(_ userId: String) {
            var isExistent : Bool = false
            for user in users {
                if userId == user.name {
                    loggedUser = user
                    isExistent = true
                }
            }
            if !isExistent{
                loggedUser = DefaultUser.default
            }
        }
        
        mutating func setUserByid(_ loadedUser: User) {
            userById = loadedUser
        }
        
        struct DefaultUser {
            static var `default`: User {
                return User(id: "-1",age: 12,wohnort: "",zitat: "",pictureURL: "./", name: "No User Found", pos_longitude: 0.0, pos_latitude: 0.0, driver: false)
            }
        }
    }
    
    struct RideModel {
        struct Ride: Codable, Identifiable, Hashable {
            var id: String
            var user_id: String
            var startpunkt_ort: String
            var startpunkt_longitude: Double
            var startpunkt_latitude: Double
            var endpunkt_ort: String
            var endpunkt_longitude: Double
            var endpunkt_latitude: Double
        }
        
        private (set) var rides = [Ride]()
        private (set) var rideById = DefaultRide.default
        
        mutating func setRides(_ loadedRides: [Ride]) {
            rides = loadedRides
        }
        
        mutating func setRideById(_ loadedRide: Ride) {
            rideById = loadedRide
        }
        
        func getRideById(_ id: String) -> Ride? {
                return rides.first { $0.id == id }
        }
        
        struct DefaultRide {
            static var `default`: Ride {
                return Ride(id: "-1", user_id: "Ride Not Found", startpunkt_ort: "Not Found", startpunkt_longitude: 0.0, startpunkt_latitude: 0.0, endpunkt_ort: "Not Found", endpunkt_longitude: 0.0, endpunkt_latitude: 0.0)
            }
        }
    }
    
    struct SwipeModel {
        struct Swipe: Codable, Identifiable, Hashable {
            var id: String
            var rideId: String
            var firstUserId: String
            var secondUserId: String
            var firstAnswer: Bool?
            var secondAnswer: Bool?
        }
        
        private (set) var swipes = [Swipe]()
        private (set) var swipesByLogin = [Swipe]()
        
        mutating func setSwipes(_ loadedSwipes: [Swipe]) {
            swipes = loadedSwipes
        }
        
        mutating func setSwipesByLogin (_ loadedSwipesByLogin: [Swipe]) {
            swipesByLogin = loadedSwipesByLogin
        }
    }
    
    struct MatchModel {
        struct Match: Codable, Identifiable, Hashable {
            var id: String
            var rideId: String
            var swipeId: String
            var firstUserId: String
            var secondUserId: String
        }
        
        private (set) var matches = [Match]()
        
        mutating func setMatches(_ loadedMatches: [Match]) {
            matches = loadedMatches
        }
    }
}


