//
//  HomeView.swift
//  DrivUs
//
//  Created by Natalie Schmitzberger on 03.04.24.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        VStack {
            Spacer()
            
            // Zwei Hauptbuttons in der Mitte
            VStack(spacing: 20) {
                Button("Nach Hause") {
                    print("Nach Hause")
                }
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
                
                Button("Suchen") {
                    print("Suchen")
                }
                .padding()
                .background(Color.green)
                .foregroundColor(.white)
                .cornerRadius(10)
            }
            
            Spacer()
            
            // Eine "Fake"-TabBar könnte man hier am unteren Rand platzieren,
            // aber in SwiftUI verwendet man stattdessen eine echte TabView.
        }.tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            .tabItem {
                Image(systemName: "house.fill")
                Text("Home")
            }
    }
}

#Preview {
    HomeView()
}
