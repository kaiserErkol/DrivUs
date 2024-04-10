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
    Carpool(from: "MÜNCHEN", to: "BERLIN", time: "08:00", driver: "Max Mustermann", swipe: true),
    Carpool(from: "THENING", to: "LEONDING", time: "09:30", driver: "Maria Musterfrau", swipe: true),
    Carpool(from: "THENING", to: "LEONDING", time: "11:15", driver: "John Doe", swipe: false),
    Carpool(from: "HITZING", to: "THENING", time: "11:15", driver: "John Doe", swipe: false),
    Carpool(from: "OTTENSHEIM", to: "LINZ", time: "11:15", driver: "John Doe", swipe: true)
]
