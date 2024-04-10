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
                VStack(spacing:0) {
                    
                    if currentIndex < carpoolData.count {
                        let carpool = carpoolData[currentIndex]
                        Map(coordinateRegion: $region)
                            .frame(height: UIScreen.main.bounds.height / 2)
                            .frame(width: UIScreen.main.bounds.width) // 1/3 des Bildschirmes
                            
                            
                        Color.blue
                                // Ignore just for the color
                                .overlay(
                        VStack {
                            //buttons
                            HStack (spacing:100){
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
                            }.padding(.top,5)
                            
                            Text("\(carpool.from) - \(carpool.to)").padding(.top,20)
                            Text("\(carpool.time)").bold().padding()
                            Text("\(carpool.driver)").padding(5)
                            // check or x
                            
                        }.frame(width: UIScreen.main.bounds.width)
                        .padding(.bottom,10)
                        .frame(height: UIScreen.main.bounds.height*1.5))
                        
                                
                        .cornerRadius(20)
                        .shadow(color: .black, radius: 15,x:-0,y:-5)
                        .frame(width: UIScreen.main.bounds.width)
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
                        .frame(height: UIScreen.main.bounds.height / 3)
                        
                    } else {
                        // Anzeigen, dass keine weiteren Matches vorhanden sind
                        Text("No Matches More")
                    }
                    Spacer()
                    
                }.frame(width: UIScreen.main.bounds.width)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(.bottom,20)
        
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


struct SwipeView_Previews: PreviewProvider {
    static var previews: some View {
        let sampleCarpoolData = [
            Carpool(from: "GMUNDEN", to: "THENING", time: "10:00", driver: "Natalie Schmitzberger", swipe: true),
            Carpool(from: "C", to: "D", time: "12:00", driver: "Alice P.", swipe: false)
        ]
        
        return SwipeView(carpoolData: sampleCarpoolData)
            .environmentObject(MatchViewModel()) // Wenn du einen MatchViewModel benötigst
    }
}
