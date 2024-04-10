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
            Image(systemName: "mappin")
                .resizable()
                .frame(width: 150, height: 150)
                .padding(50)
                .background(Color.green)
                .foregroundColor(.black)
                .clipShape(Circle())
                .padding(.horizontal,80)
                .padding(.vertical,20)
                
                // Zwei Hauptbuttons in der Mitte
                VStack(spacing: -15) {
                    Button("NACHHAUSE") {
                        print("Nach Hause")
                    }
                    .padding(.horizontal,80)
                    .padding(.vertical,20)
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(20)
                    .shadow(color: .black, radius: 3,x:3,y:3)
                    .frame(width: UIScreen.main.bounds.width/1)
                    .frame(height: 100) // 1/3 des Bildschirmes
                    Button("SUCHEN") {
                        print("Suchen")
                    }
                    .padding(.horizontal,100)
                    .padding(.vertical,20)
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(20)
                    .shadow(color: .black, radius: 3,x:3,y:3)
                    .frame(width: UIScreen.main.bounds.width/1)
                    .frame(height: 100)
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
