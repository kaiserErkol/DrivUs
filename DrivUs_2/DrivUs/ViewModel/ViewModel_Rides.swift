//
//  ViewModel_Rides.swift
//  DrivUs
//
//  Created by MacBook on 30.04.24.
//

import Foundation

class ViewModel_Rides: ObservableObject {
    @Published private (set) var model = RideModel()
    
    var matchManager = MatchManager()
    
    var rides: [RideObject] {
        model.rides
    }
    
    func setRides(rides: [RideObject]) {
        model.setRides(rides)
    }
    
    func ridesLoaded(_ rides: [RideObject]) {
        model.setRides(rides)
    }
    
    func fetchRides() {
        JsonService.shared.fetchRides { [weak self] rides in
            DispatchQueue.main.async {
                self?.setRides(rides: rides ?? [])
            }
        }
    }
    
    func fetchRideById(_ rideId: String) -> RideObject? {
        var rideObject: RideObject?
        
        JsonService.shared.fetchRideById(byID: rideId) { ride in
            rideObject = ride
        }
            
        return rideObject
    }
    
}
