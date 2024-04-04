//
//  SwipeView.swift
//  DrivUs
//
//  Created by Natalie Schmitzberger on 02.04.24.
//
import SwiftUI
import MapKit

struct SwipeView: View {
    @State private var currentIndex: Int = 0
    @State private var isMatchShown: Bool = false
    @EnvironmentObject var viewModel: MatchViewModel
    let carpoolData: [Carpool]
    //fiar standort
    @State private var region = MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 40.7128, longitude: -74.0060),
            span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)
        )

    var body: some View {
        ZStack {
            if isMatchShown, let match = viewModel.matches.last {
                // MatchView anzeigen, wenn es ein Match gibt
                MatchView(carpool: carpoolData[currentIndex], onClose: { isMatchShown = false }, onNext: {
                        // Beim Schließen zum nächsten Eintrag springen
                        isMatchShown = false
                        currentIndex += 1
                    })
            } else {
                VStack {
                    Map(coordinateRegion: $region)
                        .frame(height: UIScreen.main.bounds.height / 3) // 1/3 des Bildschirmes
                        .edgesIgnoringSafeArea(.top)
                    Spacer()
                    if currentIndex < carpoolData.count {
                        let carpool = carpoolData[currentIndex]
                        VStack {
                            Text("\(carpool.from) nach \(carpool.to)").padding()
                            Text("\(carpool.time)").bold().padding()
                            Text("\(carpool.driver)").padding()
                        }
                        .padding()
                        .background(Color.mint)
                        .cornerRadius(10)
                        .shadow(radius: 5)
                        .gesture(
                            DragGesture()
                                .onEnded { gesture in
                                    if gesture.translation.width < -100 {
                                        // Swipe Left
                                        rejectCurrent()
                                    } else if gesture.translation.width > 100 {
                                        // Swipe Right
                                        acceptCurrent()
                                    }
                                }
                        )
                        .animation(.easeInOut, value: currentIndex)
                        .transition(.slide)
                    } else {
                        // Anzeigen, dass keine weiteren Matches vorhanden sind
                        Text("No Matches More")
                    }
                    Spacer()
                    HStack {
                        Button(action: {
                            rejectCurrent()
                        }) {
                            Image(systemName: "xmark")
                                .padding()
                                .background(Color.red)
                                .foregroundColor(.white)
                                .clipShape(Circle())
                                
                        }

                        Button(action: {
                            acceptCurrent()
                        }) {
                            Image(systemName: "checkmark")
                                .padding()
                                .background(Color.green)
                                .foregroundColor(.white)
                                .clipShape(Circle())
                        }
                    }.padding()
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        
    }

    private func acceptCurrent() {
        if currentIndex < carpoolData.count {
            let carpool = carpoolData[currentIndex]
            if carpool.swipe {
                viewModel.addMatch(carpool)
                isMatchShown = true
            } else {
                moveToNext()
            }
        }
    }

    private func rejectCurrent() {
        moveToNext()
    }

    private func moveToNext() {
        if currentIndex < carpoolData.count - 1 {
            currentIndex += 1
        } else {
    
            isMatchShown = false
        }
    }
}
