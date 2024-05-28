//
//  MatchManager.swift
//  DrivUs
//
//  Created by MacBook on 30.04.24.
//

import Foundation

/*
 import Foundation

 class MatchManager {
     let viewModelRides: ViewModel_Rides
     let viewModelUser: ViewModel_User
     
     init(viewModelRides: ViewModel_Rides, viewModelUser: ViewModel_User) {
         self.viewModelRides = viewModelRides
         self.viewModelUser = viewModelUser
     }
     
     func findMatchingUsers() -> [UserObject] {
         // Example logic to find matching users
         // This example assumes you want to find users who have the same starting point
         var matchingUsers: [UserObject] = []
         
         for ride in viewModelRides.rides {
             let user = viewModelUser.getUserById(id: ride.userId)
             if ride.startPointOrt == "SomeCriteria" {
                 matchingUsers.append(user)
             }
         }
         
         return matchingUsers
     }
 }

 
 import SwiftUI

 struct PersonView: View {
     @StateObject var viewModel_rides = ViewModel_Rides()
     @StateObject var viewModel_user = ViewModel_User()
     @State private var matchingUsers: [UserObject] = []
     
     var body: some View {
         NavigationView {
             VStack {
                 List(viewModel_rides.rides, id: \.self) { ride in
                     VStack(alignment: .leading) {
                         Text("Von: \(ride.startPointOrt) - \(ride.endPointOrt)")
                         Text("Fahrer: \(viewModel_user.getUserById(id: ride.userId).name)")
                     }
                 }
                 .navigationTitle("Meine Matches")
                 .task {
                     viewModel_rides.fetchRides()
                     viewModel_user.fetchUsers()
                 }
                 
                 Button("Find Matching Users") {
                     let matchManager = MatchManager(viewModelRides: viewModel_rides, viewModelUser: viewModel_user)
                     matchingUsers = matchManager.findMatchingUsers()
                     print("Matching users: \(matchingUsers)")
                 }
                 .padding()
                 .background(Color.blue)
                 .foregroundColor(.white)
                 .cornerRadius(10)
                 
                 List(matchingUsers, id: \.self) { user in
                     Text(user.name)
                 }
             }
         }
     }
 }

 #Preview {
     PersonView()
 }

 */
