//
//  ViewModel_Swipes.swift
//  DrivUs
//
//  Created by Natalie Schmitzberger on 21.05.24.
//

import Foundation

class ViewModel_Swipes: ObservableObject {
    @Published private(set) var model: Model.SwipeModel
    
    init(_ model: Model.SwipeModel) {
        self.model = model
    }
    
    var swipes: [Model.SwipeModel.Swipe] {
        model.swipes
    }
    
    func setSwipes(_ swipes: [Model.SwipeModel.Swipe]) {
        print("")
        print("loaded Swipes: \(swipes)")
        print("")
        model.setSwipes(swipes)
    }
    
    func fetchUserSwipes(_ user: Model.UserModel.User) {
        
        /*
        print("Rides in FetchUserSwipes: \(rides)")
        FilterDataService.shared.createSwipes(loggedUser, swipes, rides)
        
        fetchAllSwipes()
        */
        
        print("my logged user: \(user.id)")
        
        //ERROR user ist default
        setSwipes(MatchManager.shared.filterSwipesByUser(swipes, user))
    }
    
    func fetchAllSwipes() {
        SwipesService.shared.fetchAllSwipes { [weak self] swipes in
            DispatchQueue.main.async {
                self?.setSwipes(swipes ?? [])
            }
        }
    }
    
    func acceptSwipe(swipeId: String, acceptRide: Bool, user: Model.UserModel.User) {
        SwipesService.shared.updateSwipe(swipeId, acceptRide, user) { success in
            if success {
                print("")
                print("updated swipe")
                print("")
            }
            else {
                print("")
                print("failed at updating swipe")
                print("")
            }
        }
        
    }
}
