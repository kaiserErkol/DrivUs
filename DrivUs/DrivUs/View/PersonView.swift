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
    @ObservedObject var viewModel_swipes: ViewModel_Swipes
    
    var body: some View {
        NavigationView {
            List(viewModel_matches.matches) { match in
                HStack{
                    Image("\(viewModel_user.getUserById(match.rideId)?.name ?? "Unknown")")
                        .resizable()
                        .frame(width: 70, height: 70)
                        .background(Color.drivusBlue)
                        .foregroundColor(.white)
                        .clipShape(Circle())
                        .padding(.top,2)
                        .padding(.bottom,2)
                    
                    VStack(alignment: .leading) {
                        Text(" \(viewModel_user.getUserById(match.rideId)?.name ?? "Unknown")")
                            .foregroundColor(.white)
                            .font(.title)
                        Text("   \(viewModel_rides.getRideById(match.rideId)?.startpunkt_ort ?? "Unknown") - \(viewModel_rides.getRideById(match.rideId)?.endpunkt_ort ?? "Unknown")")
                        .font(.body)
                        .foregroundColor(.black)
                    }
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
            .onAppear {
                if viewModel_swipes.newMatch {
                    viewModel_matches.fetchAllMatches()
                    viewModel_matches.fetchUserMatches(viewModel_user.loggedUser)
                    print("Bruder neuer Swipe aber kein Anzeigen weil ja")
                }
                else {
                    print("kein neueer Swipe Bruder")
                }
            }
        }.navigationViewStyle(StackNavigationViewStyle())
    }
     
}
