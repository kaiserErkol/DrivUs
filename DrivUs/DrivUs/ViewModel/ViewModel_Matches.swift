//
//  ViewModel_Matches.swift
//  DrivUs
//
//  Created by MacBook on 30.04.24.
//

import Foundation

class ViewModel_Matches: ObservableObject {
    @Published private(set) var model: MatchModel
    
    init(model: MatchModel) {
        self.model = model
    }
    
    var rides: [MatchObject] {
        model.matches
    }
    
    func ridesLoaded(_ matches: [MatchObject]) {
        model.setMatches(matches)
    }
}
