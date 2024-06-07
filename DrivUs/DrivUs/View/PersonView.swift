//
//  PersonView.swift
//  DrivUs
//
//  Created by Natalie Schmitzberger on 03.04.24.
//
import SwiftUI

struct PersonView: View {
    @ObservedObject var viewModel_rides: ViewModel_Rides
    @ObservedObject var viewModel_user: ViewModel_User
    @ObservedObject var viewModel_matches: ViewModel_Matches
    
    var body: some View {
        NavigationView {
            List(viewModel_matches.matches) { match in
                VStack(alignment: .leading) {
                    Text("Match Nr.: \(match.id)")
                    Text("Ride Nr.: \(match.rideId)")
                    Text("firstUser: \(match.firstUserId)")
                    Text("secUser: \(match.secondUserId)")
                }
            }
            .navigationTitle("Meine Matches")
        }
    }
     
}
