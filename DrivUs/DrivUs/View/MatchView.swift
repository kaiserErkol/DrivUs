//
//  MatchView.swift
//  DrivUs
//
//  Created by Natalie Schmitzberger on 03.04.24.
//
import SwiftUI

struct MatchView: View {
    let carpool: Carpool
    let onClose: () -> Void
    let onNext: () -> Void // Methode, um zum nächsten Eintrag zu gehen
    
    var body: some View {
        VStack {
            Text("It's a Match!")
                .font(.title)
                .padding()
            
            VStack {
                Text("\(carpool.from) nach \(carpool.to)")
                Text("\(carpool.time)").bold()
                Text("\(carpool.driver)")
            }
            .padding()
            .background(Color.white)
            .cornerRadius(10)
            .shadow(radius: 5)
            
            Button(action: {
                onNext() // Rufe onNext auf, um zum nächsten Eintrag zu springen
            }) {
                Image(systemName: "xmark")
                    .padding()
                    .background(Color.red)
                    .foregroundColor(.white)
                    .clipShape(Circle())
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.gray.opacity(0.5))
    }
}
