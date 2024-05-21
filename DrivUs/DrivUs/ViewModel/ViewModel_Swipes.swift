//
//  ViewModel_Swipes.swift
//  DrivUs
//
//  Created by Natalie Schmitzberger on 21.05.24.
//

import Foundation

class ViewModel_Swipes: ObservableObject {
    @Published private(set) var model: SwipeModel
    
    init(model: SwipeModel) {
        self.model = model
    }
    
    var rides: [SwipeObject] {
        model.swipes
    }
    
    func ridesLoaded(_ swipes: [SwipeObject]) {
        model.setSwipes(swipes)
    }
}
