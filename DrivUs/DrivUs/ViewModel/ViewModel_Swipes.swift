//
//  ViewModel_Swipes.swift
//  DrivUs
//
//  Created by Natalie Schmitzberger on 21.05.24.
//

import Foundation

class ViewModel_Swipes: ObservableObject {
    @Published private(set) var model = SwipeModel()
    
    
    var swipes: [SwipeObject] {
        model.swipes
    }
    
    func setSwipes(swipes: [SwipeObject]) {
        model.setSwipes(swipes)
        print("Swipes loadedL: \(swipes)")
    }
    
    func swipesLoaded(_ swipes: [SwipeObject]) {
        model.setSwipes(swipes)
    }
    
    func fetchSwipes() {
        SwipesService.shared.fetchSwipes { [weak self] swipes in
            DispatchQueue.main.async {
                self?.setSwipes(swipes: swipes ?? [])
            }
        }
    }
}
