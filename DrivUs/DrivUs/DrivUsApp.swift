//
//  DrivUsApp.swift
//  DrivUs
//
//  Created by MacBook on 05.03.24.
//

import SwiftUI

@main
struct DrivUsApp: App {
    var viewModel = MatchViewModel()
    
    var body: some Scene {
        WindowGroup {
                    ContentView() // Dein Hauptansicht
                        .environmentObject(viewModel)
                }
    }
}
