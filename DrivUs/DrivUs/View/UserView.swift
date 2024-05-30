//
//  UserView.swift
//  DrivUs
//
//  Created by Natalie Schmitzberger on 30.05.24.
//

import SwiftUI

struct UserView: View {
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
                                    .padding()
                                
                                Button(action: {
                                    viewModel_user.setCurrUser(userIdInput)
                                    sent = true
                                }) {
                                    Text("Senden")
                                        .foregroundColor(.white)
                                        .padding()
                                        .background(Color.blue)
                                        .cornerRadius(8)
                                }
                            }
                            .task {
                                viewModel_user.fetchUsers()
                            }
                            .padding()
        }else{
            
            
            VStack(alignment: .leading, spacing: 10) {
                Text("Name: \(viewModel_user.currUser.name)")
                        Text("Position: (\(viewModel_user.getCurrUser().pos_latitude), \(viewModel_user.getCurrUser().pos_longitude))")
                        Text("Driver: \(viewModel_user.getCurrUser().driver ? "Yes" : "No")")
                    }
                    .padding()
        }
        
    }
}
