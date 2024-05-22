//
//  SwipesService.swift
//  DrivUs
//
//  Created by Natalie Schmitzberger on 21.05.24.
//

import Foundation

import Foundation

fileprivate let urlString = "http://localhost:3000/swipes"

func loadAllSwipes() async -> [SwipeObject]{
    var swipes = [SwipeObject]()
    let url = URL(string: urlString)!
    
    if let (data, _) = try? await URLSession.shared.data(from: url) {
        if let loadedSwipes = try? JSONDecoder().decode([SwipeObject].self, from: data) {
            swipes = loadedSwipes
        } else {
            print("failed to decode")
        }
    } else {
        print("failed to load url")
    }
    print(swipes)
    return swipes
}
