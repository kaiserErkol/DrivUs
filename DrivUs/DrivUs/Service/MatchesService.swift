//
//  MatchesService.swift
//  DrivUs
//
//  Created by MacBook on 30.04.24.
//

import Foundation

fileprivate let urlString = "http://localhost:3000/matches"

func loadAllMatches() async -> [MatchObject]{
    var matches = [MatchObject]()
    let url = URL(string: urlString)!
    
    if let (data, _) = try? await URLSession.shared.data(from: url) {
        if let loadedMatches = try? JSONDecoder().decode([MatchObject].self, from: data) {
            matches = loadedMatches
        } else {
            print("failed to decode")
        }
    } else {
        print("failed to load url")
    }
    print(matches)
    return matches
}
