//
//  RideModel.swift
//  DrivUs
//
//  Created by MacBook on 30.04.24.
//

import Foundation

struct RideModel {
    private (set) var rides = [RideObject]()
    
    mutating func setRides(_ loadedRides: [RideObject]) {
        rides = loadedRides
    }
}

struct RideObject: Codable, Identifiable, Hashable {
    var id: String
    var userId: String
    var startPointOrt: String
    var startPointLongitude: Double
    var startPointLatitude: Double
    var endPointOrt: String
    var endPointLongitude: Double
    var endPointLatitude: Double
    
    static var `simulation`: RideObject {
        return RideObject(id: "0", userId: "0", startPointOrt: "Enns", startPointLongitude: 14.4791, startPointLatitude: 48.2215, endPointOrt: "Linz", endPointLongitude: 14.2861, endPointLatitude: 48.3064)
    }
}
