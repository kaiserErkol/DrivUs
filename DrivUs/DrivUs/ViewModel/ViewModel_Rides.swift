//
//  ViewModel_Rides.swift
//  DrivUs
//
//  Created by MacBook on 30.04.24.
//

import Foundation

class ViewModel_Rides: ObservableObject {
    @Published private (set) var model = RideModel()
    
    var rides: [RideObject] {
        model.rides
    }
    
    func setRides(rides: [RideObject]) {
        model.setRides(rides)
        print("Rides loaded: \(rides)")
    }
    
    func ridesLoaded(_ rides: [RideObject]) {
        model.setRides(rides)
    }
    
    func fetchRides() {
        RidesService.shared.fetchRides { [weak self] rides in
            DispatchQueue.main.async {
                self?.setRides(rides: rides ?? [])
            }
        }
    }
    
}
