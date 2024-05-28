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
    
    var matches: [MatchObject] {
        model.matches
    }
    
    func setMatches(matches: [MatchObject]) {
        model.setMatches(matches)
        print("Matches loaded: \(matches)")
    }
    
    func matchesLoaded(_ matches: [MatchObject]) {
        model.setMatches(matches)
    }
    
    func fetchMatches() {
        MatchesService.shared.fetchMatches { [weak self] matches in
            DispatchQueue.main.async {
                self?.setMatches(matches: matches ?? [])
            }
        }
    }
}
