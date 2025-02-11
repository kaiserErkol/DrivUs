//
//  MatchManager.swift
//  DrivUs
//
//  Created by MacBook on 07.06.24.
//

import Foundation

class MatchManager {
    static let shared = MatchManager()
    
    func filterRides(rides: [Model.RideModel.Ride], user: Model.UserModel.User) -> [Model.RideModel.Ride]{
        let userRides = rides.filter { $0.user_id == user.id }
        var matchingRides: [Model.RideModel.Ride] = []
        
        for userRide in userRides {
            for ride in rides {
                if userRide.startpunkt_ort == ride.startpunkt_ort && userRide.endpunkt_ort == ride.endpunkt_ort && userRide.user_id != ride.user_id{
                    matchingRides.append(ride)
                }
            }
        }
        
        return matchingRides
    }
    
    func filterSwipesByUser(_ swipes: [Model.SwipeModel.Swipe], _ user: Model.UserModel.User) -> [Model.SwipeModel.Swipe]{
        var userSwipes: [Model.SwipeModel.Swipe] = []
        
        for swipe in swipes {
            if swipe.firstUserId == user.id {
                if (swipe.firstAnswer == nil && swipe.secondAnswer == true) || (swipe.firstAnswer == nil && swipe.secondAnswer == nil){
                    print("I check wos nil ist firstuserid")
                    userSwipes.append(swipe)
                }
            }
            else if swipe.secondUserId == user.id {
                if (swipe.secondAnswer == nil && swipe.firstAnswer == true) || (swipe.secondAnswer == nil && swipe.firstAnswer == nil){
                    print("I check wos nil ist seconduserid")
                    userSwipes.append(swipe)
                }
            }
        }
 
        print("filtered user swipes: \(userSwipes)")
        return userSwipes
    }
    
    func filterMatchesByUser(_ matches: [Model.MatchModel.Match], _ user: Model.UserModel.User) -> [Model.MatchModel.Match] {
        var userMatches: [Model.MatchModel.Match] = []
        
        for match in matches {
            if match.firstUserId == user.id {
                userMatches.append(match)
            }
            else if match.secondUserId == user.id {
                userMatches.append(match)
            }
        }
        
        return userMatches
    }
    
    func filterRideById (_ rideId: String, _ rides: [Model.RideModel.Ride]) -> Model.RideModel.Ride{
        for ride in rides {
            if rideId == ride.id {
                return ride
            }
        }
        return Model.RideModel.DefaultRide.default
    }
    
    func filterRideByUser(_ user_id: String, _ rides: [Model.RideModel.Ride]) -> Model.RideModel.Ride {
        for ride in rides {
            if user_id == ride.user_id {
                return ride
            }
        }
        return Model.RideModel.DefaultRide.default
    }
    
    func filterUserById(_ userId: String, _ users: [Model.UserModel.User]) -> Model.UserModel.User {
        for user in users {
            if userId == user.id {
                return user
            }
        }
        return Model.UserModel.DefaultUser.default
    }

}

