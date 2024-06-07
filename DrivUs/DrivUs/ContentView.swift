//
//  ContentView.swift
//  DrivUs
//
//  Created by MacBook on 05.03.24.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel_rides: ViewModel_Rides
    @ObservedObject var viewModel_users: ViewModel_User
    @ObservedObject var viewModel_matches: ViewModel_Matches
    @ObservedObject var viewModel_swipes: ViewModel_Swipes
    
    var body: some View {
        Text("this is the content view")
        
        ZStack {
             // Hintergrundfarbe der TabView
            TabView {
                HomeView()
                    .tabItem {
                        Label("Home", systemImage: "house.fill")
                    }
                
                PersonView(viewModel_rides: viewModel_rides, viewModel_user: viewModel_users, viewModel_matches: viewModel_matches)
                    .tabItem {
                        Label("Matches", systemImage: "person.fill")
                    }
                
                SwipeView(viewModel_rides: viewModel_rides, viewModel_swipes: viewModel_swipes, viewModel_users: viewModel_users)
                    .tabItem {
                        Label("Rides", systemImage: "car.fill")
                    }
                
                UserView(viewModel_user: viewModel_users)
                    .tabItem {
                        Label("Users", systemImage: "person.fill")
                    }
            }.tabViewStyle(DefaultTabViewStyle())
                .frame(width: UIScreen.main.bounds.width) // 3/4 der Breite des Bildschirms
                .background(Color.white)
                .cornerRadius(20)
                .padding(.bottom, 20)
                .padding(.top, 0)
                .padding(.vertical, 0)
            .task {
                viewModel_rides.fetchAllRides()
                viewModel_users.fetchAllUsers()
                viewModel_matches.fetchAllMatches()
                viewModel_swipes.fetchAllSwipes()
            }
        }
    }
}
