//
//  ViewModel_Rides.swift
//  DrivUs
//
//  Created by MacBook on 30.04.24.
//

import Foundation

class ViewModel_Rides: ObservableObject {
    @Published private(set) var model: RideModel
    
    init(model: RideModel) {
        self.model = model
    }
    
    var rides: [RideObject] {
        model.rides
    }
    
    func ridesLoaded(_ rides: [RideObject]) {
        model.setRides(rides)
    }
}
