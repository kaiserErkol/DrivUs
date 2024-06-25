//
//  UserView.swift
//  DrivUs
//
//  Created by Natalie Schmitzberger on 30.05.24.
//

import SwiftUI

struct UserView: View {
    @ObservedObject var viewModel_user: ViewModel_User
    
    @State  var userIdInput: String = ""
    @State  var sent: Bool = false
    
    var body: some View {
        VStack {
            if sent == false {
                VStack {
                    TextField("User Name eingeben", text: $userIdInput)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(5)
                        .background(Color.drivusBlue)
                        .cornerRadius(8)
                    
                    Button(action: {
                        viewModel_user.setLoginUser(userIdInput)
                        sent = true
                    }) {
                        Text("einloggen")
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.drivusBlue)
                            .cornerRadius(8)
                    }
                }
                .padding()
            }else{
                
                
                VStack {
                    
                    //buttons
                    
                    Image("\(viewModel_user.loggedUser.name)")
                        .resizable()
                        .frame(width: 200, height: 200)
                        .background(Color.drivusBlue)
                        .foregroundColor(.white)
                        .clipShape(Circle())
                        .padding(.top,50)
                        .padding(.bottom,10)
                    
                    Text("\(viewModel_user.loggedUser.name)")
                        .padding(5)
                        .padding(.horizontal,60)
                        .background(.white)
                        .foregroundColor(.darkDrivusBlue)
                        .cornerRadius(10)
                        .font(.title)
                    
                    Text("' \(viewModel_user.loggedUser.zitat) '")
                        .padding(.bottom,30)
                        .padding(.top,10)
                        .foregroundColor(.black)
                    
                    VStack(spacing:20){
                        Text("Alter: \(viewModel_user.loggedUser.age)")
                            .padding(10)
                        
                            .background(.darkDrivusBlue)
                            .foregroundColor(.white)
                            .shadow(color: .black, radius: 10, y: 10)
                            .cornerRadius(10)
                            .font(.subheadline)
                            .frame(minWidth: 300, maxWidth: 450)
                            .frame(idealHeight: 100)
                        
                        Text("Wohnort: \(viewModel_user.loggedUser.wohnort)")
                            .padding(10)
                            .background(.darkDrivusBlue)
                        
                            .foregroundColor(.white)
                            .shadow(color: .black, radius: 10, y: 10)
                            .cornerRadius(10)
                            .font(.subheadline)
                            .frame(minWidth: 300, maxWidth: 450)
                            .frame(idealHeight: 100)
                        
                        Text("Fahrer: \(viewModel_user.loggedUser.driver ? "Gelegentlich" : "Nein")")
                            .padding(10)
                        
                            .background(.darkDrivusBlue)
                            .foregroundColor(.white)
                            .shadow(color: .black, radius: 10, y: 10)
                            .cornerRadius(10)
                            .font(.subheadline)
                            .frame(minWidth: 300, maxWidth: 450)
                            .frame(idealHeight: 100)
                        
                    }.padding(.bottom,50)
                    
                    
                    // check or x
                    
                    Button(action: {viewModel_user.setLoginUser(Model.UserModel.DefaultUser.default.id)
                        sent = false
                    }) {
                        Text("ausloggen")
                            .foregroundColor(.white)
                            .padding(5)
                            .background(Color.drivusBlue)
                            .cornerRadius(8)
                    }.shadow(color: .darkDrivusBlue, radius: 2, y: 2)
                }
            }
        }
        
    }
}
