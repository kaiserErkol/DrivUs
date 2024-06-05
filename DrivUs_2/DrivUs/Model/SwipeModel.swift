//
//  SwipeModel.swift
//  DrivUs
//
//  Created by Natalie Schmitzberger on 21.05.24.
//

import Foundation

struct SwipeModel {
    private (set) var swipes = [SwipeObject]()
    
    mutating func setSwipes(_ loadedSwipes: [SwipeObject]) {
        swipes = loadedSwipes
    }
}

struct SwipeObject: Codable, Identifiable, Hashable {
    var id: String
    var rideId: String
    var firstUserId: String
    var secondUserId: String
    var firstAnswer: Bool
    var secondAnswer: Bool
}
