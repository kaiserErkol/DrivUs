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
    var id: Int
    var userId: Int
    var startPointOrt: String
    var startPointLongitude: Double
    var startPointLatitude: Double
    var endPointOrt: String
    var endPointLongitude: Double
    var endPointLatitude: Double
}
