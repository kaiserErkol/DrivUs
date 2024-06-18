//
//  MatchView.swift
//  DrivUs
//
//  Created by Natalie Schmitzberger on 03.04.24.
//
import SwiftUI

struct MatchView: View {
    //let carpool: Carpool
    let onClose: () -> Void
    let onNext: () -> Void // Methode, um zum nächsten Eintrag zu gehen
    
    var body: some View {
        Text("MatchView")
        /*
        VStack {
            Text("IT'S A MATCH!")
                .fontWidth(.expanded).font(.title).fontWeight(.light)
                .padding().padding(.top,150)
            HStack{
                Image(systemName: "person")
                    .resizable()
                Image(systemName: "person.fill")
                    .resizable()
            }.padding(.horizontal,100).padding(.vertical,10).padding(.bottom,20)
            VStack {
                Text("\(carpool.from) - \(carpool.to)").padding(.bottom,20)
                Text("\(carpool.time)").bold().padding(.bottom,20)
                Text("\(carpool.driver)").padding(.bottom,50)
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
            .padding(.horizontal,100)
            .padding(.top,50)
            .padding(.bottom,40)
            .background(Color.drivusBlue)
            .cornerRadius(10)
            .shadow(radius: 5)
            .foregroundColor(.white)
            
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        */
    }
}
