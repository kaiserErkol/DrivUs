//
//  RidesService.swift
//  DrivUs
//
//  Created by MacBook on 30.04.24.
//

import Foundation

fileprivate let urlString = "http://localhost:3000/rides"

func loadAllRides() async -> [RideObject]{
    var rides = [RideObject]()
    let url = URL(string: urlString)!
    
    if let (data, _) = try? await URLSession.shared.data(from: url) {
        if let loadedRides = try? JSONDecoder().decode([RideObject].self, from: data) {
            rides = loadedRides
        } else {
            print("failed to decode")
        }
    } else {
        print("failed to load url")
    }
    return rides
}
