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
                    Text(" \(viewModel_user.getUserById(match.rideId)?.name ?? "Unknown")")
                    Text("Ride Nr.: \(match.rideId)")
                    Text("firstUser: \(match.firstUserId)")
                    Text("secUser: \(match.secondUserId)")
                    .font(.body)
                    .foregroundColor(.white)
                }
                .padding(10)
                .background(Color(UIColor.drivusBlue))
                .cornerRadius(10)
                .shadow(color: Color.darkDrivusBlue.opacity(0.1), radius: 5, x: 0, y: 2)
            }
            .navigationTitle("Meine Matches")
            .padding(.top,10)
            .listStyle(InsetGroupedListStyle())
            .navigationTitle("Meine Matches")
            .task {
               viewModel_matches.fetchUserMatches(viewModel_user.loggedUser)
           }
        }.navigationViewStyle(StackNavigationViewStyle())
    }
     
}
