//
//  DrivUsApp.swift
//  DrivUs
//
//  Created by MacBook on 05.03.24.
//

import SwiftUI

fileprivate let rideModel = Model.RideModel()
fileprivate let userModel = Model.UserModel()
fileprivate let swipeModel = Model.SwipeModel()
fileprivate let matchModel = Model.MatchModel()

@main
struct DrivUsApp: App {
    
    var viewModel_rides = ViewModel_Rides(rideModel)
    var viewModel_users = ViewModel_User(userModel)
    var viewModel_swipes = ViewModel_Swipes(swipeModel)
    var viewModel_matches = ViewModel_Matches(matchModel)
    
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel_rides: viewModel_rides, viewModel_users: viewModel_users, viewModel_matches: viewModel_matches, viewModel_swipes: viewModel_swipes)
        }
    }
}
