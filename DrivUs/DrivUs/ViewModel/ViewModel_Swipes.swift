//
//  ViewModel_Swipes.swift
//  DrivUs
//
//  Created by Natalie Schmitzberger on 21.05.24.
//

import Foundation

class ViewModel_Swipes: ObservableObject {
    @Published private(set) var model: Model.SwipeModel
    @Published private(set) var model_rides : Model.RideModel
    @Published private(set) var model_users: Model.UserModel
    
    init(_ model: Model.SwipeModel, _ model_rides: Model.RideModel, _ model_users: Model.UserModel) {
        self.model = model
        self.model_rides = model_rides
        self.model_users = model_users
    }
    
    var swipes: [Model.SwipeModel.Swipe] {
        model.swipes
    }
    
    var rides: [Model.RideModel.Ride] {
        model_rides.rides
    }
    
    var loggedUser: Model.UserModel.User {
        model_users.loggedUser
    }
    
    func setSwipes(_ swipes: [Model.SwipeModel.Swipe]) {
        print("Swipes: \(swipes)")
        model.setSwipes(swipes)
    }
    
    func fetchUserSwipes() {
        print("Rides in FetchUserSwipes: \(rides)")
        FilterDataService.shared.createSwipes(loggedUser, swipes, rides)
        
        fetchAllSwipes()
        
        self.setSwipes(MatchManager.shared.filterSwipesByUser(swipes, loggedUser))
    }
    
    func fetchAllSwipes() {
        SwipesService.shared.fetchAllSwipes { [weak self] swipes in
            DispatchQueue.main.async {
                self?.setSwipes(swipes ?? [])
            }
        }
    }
}
