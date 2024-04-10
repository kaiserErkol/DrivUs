//
//  ContentView.swift
//  DrivUs
//
//  Created by MacBook on 05.03.24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        
        ZStack {
             // Hintergrundfarbe der TabView
            TabView {
                HomeView()
                    .tabItem {
                        Label("Home", systemImage: "house.fill")
                    }
                
                PersonView()
                    .tabItem {
                        Label("Matches", systemImage: "person.fill")
                    }
                
                SwipeView(carpoolData: sampleCarpoolData)
                    .tabItem {
                        Label("Rides", systemImage: "car.fill")
                    }
            }.tabViewStyle(DefaultTabViewStyle())
                .frame(width: UIScreen.main.bounds.width) // 3/4 der Breite des Bildschirms
                .background(Color.white)
                .cornerRadius(20)
                .padding(.bottom, 20)
                .padding(.top, 0)
                .padding(.vertical, 0)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
