//
//  ViewModel_Swipes.swift
//  DrivUs
//
//  Created by Natalie Schmitzberger on 21.05.24.
//

import Foundation

class ViewModel_Swipes: ObservableObject {
    @Published private(set) var model = SwipeModel()
        
    var swipes: [SwipeObject] {
        return model.swipes
    }
    
    func getSwipes() -> [SwipeObject] {
        print("Model Swipes")
        print("---------------------------------")
        print(model.swipes)
        return model.swipes
    }
    
    func setSwipes(swipes: [SwipeObject]) {
        model.setSwipes(swipes)
    }
    
    func swipesLoaded(_ swipes: [SwipeObject]) {
        model.setSwipes(swipes)
    }
    
    func fetchSwipes() {
        JsonService.shared.fetchSwipes { [weak self] swipes in
            DispatchQueue.main.async {
                self?.setSwipes(swipes: swipes ?? [])
            }
        }
    }
    
    func acceptSwipe(swipeId: String, acceptRide: Bool, userId: String) {
        JsonService.shared.updateSwipeRideId(swipeId: swipeId, acceptRide: acceptRide, userId: userId) { success in
            if success {
            } else {
            }
        }
    }
}
