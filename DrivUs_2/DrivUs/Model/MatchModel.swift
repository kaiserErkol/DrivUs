//
//  MatchModel.swift
//  DrivUs
//
//  Created by MacBook on 30.04.24.
//

import Foundation

struct MatchObject: Codable, Identifiable, Hashable{
    var id: String
    var user_id_1: String
    var user_id_2: String
}

struct MatchModel {
    private (set) var matches = [MatchObject]()
    
    mutating func setMatches(_ loadedMatches: [MatchObject]) {
        matches = loadedMatches
    }
}
