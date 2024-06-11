//
//  ViewModel_Rides.swift
//  DrivUs
//
//  Created by MacBook on 30.04.24.
//

import Foundation

class ViewModel_Rides: ObservableObject {
    @Published private (set) var model: Model.RideModel
    
    init(_ model: Model.RideModel) {
        self.model = model
    }
    
    var rides: [Model.RideModel.Ride] {
        model.rides
    }
    
    var rideById: Model.RideModel.Ride {
        model.rideById
    }
    
    func setRides(_ rides: [Model.RideModel.Ride]) {
        print("loaded Rides: \(rides)")
        print("")
        model.setRides(rides)
    }
    
    func setRideById(_ ride: Model.RideModel.Ride) {
        model.setRideById(ride)
    }
    
    func fetchRideById(_ id: String) -> Model.RideModel.Ride?{
        
        return MatchManager.shared.filterRideById(id, rides)
        /*
        RidesService.shared.fetchRideById(byID: id) { [weak self] ride in
            DispatchQueue.main.async {
                self?.setRideById(ride ?? Model.RideModel.DefaultRide.default)
            }
        }
         */
    }
    
    func fetchAllRides() {
        RidesService.shared.fetchAllRides { [weak self] rides in
            DispatchQueue.main.async {
                self?.setRides(rides ?? [])
            }
        }
    }
}
