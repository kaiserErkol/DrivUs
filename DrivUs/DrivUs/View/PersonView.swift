//
//  PersonView.swift
//  DrivUs
//
//  Created by Natalie Schmitzberger on 03.04.24.
//
import SwiftUI

struct PersonView: View {
    @EnvironmentObject var viewModel: MatchViewModel
    
    var body: some View {
        NavigationView {
            List(viewModel.matches, id: \.self) { match in
                VStack(alignment: .leading) {
                    Text("Von: \(match.from) - \(match.to)")
                    Text("Uhrzeit: \(match.time)")
                    Text("Fahrer: \(match.driver)")
                }
            }
            .navigationTitle("Meine Matches")
        }
    }
}
