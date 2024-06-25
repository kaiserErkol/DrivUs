//
//  PersonDetailView.swift
//  DrivUs
//
//  Created by MacBook on 25.06.24.
//

import SwiftUI

struct PersonDetailView: View {
    @ObservedObject var viewModelRides: ViewModel_Rides

    var match: Model.MatchModel.Match

    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                if let rideByMatch = viewModelRides.fetchRideById(match.rideId) {
                    MapView(
                        sp_latitude: rideByMatch.startpunkt_latitude,
                        sp_longitude: rideByMatch.startpunkt_longitude,
                        ep_latitude: rideByMatch.endpunkt_latitude,
                        ep_longitude: rideByMatch.endpunkt_longitude,
                        startName: rideByMatch.startpunkt_ort,
                        endName: rideByMatch.endpunkt_ort
                    )
                    .frame(height: 400)
                    
                    VStack(spacing: 10) {
                        VStack {
                            Text("\(rideByMatch.startpunkt_ort) - \(rideByMatch.endpunkt_ort)")
                                .padding(.top, 20)
                                .foregroundColor(.black)
                                .kerning(7)
                        }
                        .frame(width: UIScreen.main.bounds.width)
                        .padding(.bottom, 10)

                        Button(action: {
                            // Button action here
                        }) {
                            Text("Anfrage senden")
                                .foregroundColor(.white)
                                .padding()
                                .background(Color.darkDrivusBlue)
                                .cornerRadius(10)
                        }

                    }
                    .padding(.top, 20)
                    .padding([.leading, .trailing], 16)
                } else {
                    Text("No ride found")
                        .padding()
                        .foregroundColor(.black)
                }
            }
            .frame(width: UIScreen.main.bounds.width)
            .cornerRadius(20)
        }
    }
}
