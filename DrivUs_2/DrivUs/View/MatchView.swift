//
//  MatchView.swift
//  DrivUs
//
//  Created by Natalie Schmitzberger on 03.04.24.
//
import SwiftUI

struct MatchView: View {
    @ObservedObject var viewModel_user = ViewModel_User()
    
    let ride: RideObject
    let onClose: () -> Void
    let onNext: () -> Void // Methode, um zum nächsten Eintrag zu gehen
    
    var body: some View {
        VStack {
            let driver: UserObject = viewModel_user.getUserById(id: ride.user_id)!
            
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
                Text("\(ride.startpunkt_ort) - \(ride.endpunkt_ort)").padding(.bottom,20)
                Text("\(driver.name)").padding(.bottom,50)
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
        
    }
}
