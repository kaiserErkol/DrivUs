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
        return swipes.filter { $0.firstUserId == user.id || $0.secondUserId == user.id }
    }

}

