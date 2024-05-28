//
//  PersonView.swift
//  DrivUs
//
//  Created by Natalie Schmitzberger on 03.04.24.
//
import SwiftUI

struct PersonView: View {
    @ObservedObject var viewModel_rides = ViewModel_Rides()
    @ObservedObject var viewModel_user = ViewModel_User()
    
    var body: some View {
        NavigationView {
            List(viewModel_rides.rides, id: \.self) { ride in
                VStack(alignment: .leading) {
                    Text("Von: \(ride.startPointOrt) - \(ride.endPointOrt)")
                    Text("Fahrer: \(viewModel_user.getUserById(id: ride.userId).name)")
                }
            }
            .navigationTitle("Meine Matches")
            .task {
                viewModel_rides.fetchRides()
            }
        }
    }
}
