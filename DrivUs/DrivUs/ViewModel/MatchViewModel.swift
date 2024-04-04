//
//  MatchesViewModel.swift
//  DrivUs
//
//  Created by Natalie Schmitzberger on 03.04.24.
//

import SwiftUI

// ViewModel zur Verwaltung der Matches
class MatchViewModel: ObservableObject {
    @Published var matches: [Carpool] = []
    
    func addMatch(_ match: Carpool) {
        matches.append(match)
    }
}

// Struktur für Fahrgemeinschaftsdaten
struct Carpool: Hashable {
    let from: String
    let to: String
    let time: String
    let driver: String
    var swipe: Bool
}

// Beispiel-Daten
let sampleCarpoolData = [
    Carpool(from: "München", to: "Berlin", time: "08:00", driver: "Max Mustermann", swipe: true),
    Carpool(from: "Thening", to: "Leonding", time: "09:30", driver: "Maria Musterfrau", swipe: true),
    Carpool(from: "Thening", to: "Leonding", time: "11:15", driver: "John Doe", swipe: false),
    Carpool(from: "Hitzing", to: "Fumfum", time: "11:15", driver: "John Doe", swipe: false),
    Carpool(from: "Stadt Eiiiii", to: "Stadt F", time: "11:15", driver: "John Doe", swipe: true)
]
