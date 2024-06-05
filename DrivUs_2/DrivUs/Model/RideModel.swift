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
    var user_id: String
    var startpunkt_ort: String
    var startpunkt_longitude: Double
    var startpunkt_latitude: Double
    var endpunkt_ort: String
    var endpunkt_longitude: Double
    var endpunkt_latitude: Double
    
    static var `simulation`: RideObject {
        return RideObject(id: "0", user_id: "0", startpunkt_ort: "Enns", startpunkt_longitude: 14.4791, startpunkt_latitude: 48.2215, endpunkt_ort: "Linz", endpunkt_longitude: 14.2861, endpunkt_latitude: 48.3064)
    }
}
