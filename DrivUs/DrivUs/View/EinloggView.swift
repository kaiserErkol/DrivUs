//
//  EinloggView.swift
//  DrivUs
//
//  Created by Natalie Schmitzberger on 31.05.24.
//
/*
import SwiftUI

struct EinloggView: View {
    @ObservedObject var viewModel_rides = ViewModel_Rides()
    @ObservedObject var viewModel_user = ViewModel_User()
    @State  var userIdInput: String = ""
    @State  var currUser: UserObject?
    @State  var sent: Bool = false
    
    var body: some View {
        if sent == false {
            VStack {
                TextField("User ID eingeben", text: $userIdInput)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(5)
                    .background(Color.drivusBlue)
                    .cornerRadius(8)
                
                Button(action: {
                    viewModel_user.setCurrUser(userIdInput)
                    sent = true
                }) {
                    Text("einloggen")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.drivusBlue)
                        .cornerRadius(8)
                }
            }
            .task {
                viewModel_user.fetchUsers()
            }
            .padding()
        }else{
            UserView()
        }
    }
}

#Preview {
    EinloggView()
}
