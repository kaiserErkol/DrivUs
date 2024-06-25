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
        VStack {
            let loggedUserId = viewModel_user.loggedUser.id
            
            NavigationStack {
                List(viewModel_matches.matches) { match in
                    let userMatchId = (match.firstUserId != loggedUserId) ? match.firstUserId : match.secondUserId
                    
                    let userById = viewModel_user.fetchUserById(userMatchId)

                    NavigationLink(value: match) {
                        HStack{
                            Image("\(userById?.name ?? "Unknown")")
                                .resizable()
                                .frame(width: 70, height: 70)
                                .foregroundColor(.darkDrivusBlue)
                                .clipShape(Circle())
                                .padding(.top,2)
                                .padding(.bottom,2)
                            
                            VStack(alignment: .leading) {
                                Text(" \(userById?.name ?? "Unknown")")
                                    .foregroundColor(.darkDrivusBlue)
                                    .font(.title)
                                Text("\(viewModel_rides.getRideById(match.rideId)?.startpunkt_ort ?? "Unknown") - \(viewModel_rides.getRideById(match.rideId)?.endpunkt_ort ?? "Unknown")")
                                    .font(.body)
                                    .foregroundColor(.drivusBlue)
                            }
                        }
                        .cornerRadius(10)
                    }
                }
                .navigationTitle("Meine Matches")
                .foregroundColor(.drivusBlue)
                .padding(.top,30)
                .navigationTitle("Meine Matches")
                .foregroundColor(.drivusBlue)
                .task {
                    viewModel_matches.fetchUserMatches(viewModel_user.loggedUser)
                }
                .navigationDestination(for: Model.MatchModel.Match.self, destination: { match in
                    PersonDetailView(viewModelRides: viewModel_rides, match: match)
                })
            }
        }
    }
}
