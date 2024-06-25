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
                Image("logodesi2")
                    .resizable()
                    .frame(width: 400, height: 230)
                    .padding(.top,-150)
                    
                VStack (spacing: 2){
                    Text("Willkommen !")
                        .foregroundColor(.drivusBlue)
                        .padding(.horizontal,10)
                        .padding(.vertical,10)
                        .cornerRadius(20)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(.bottom, -20)
                        .padding(.top,60)
                    Text("logge dich bitte ein um fortzufahren")
                        .foregroundColor(.drivusBlue)
                        .padding(.horizontal,10)
                        .padding(.vertical,10)
                        .font(.caption)
                        .cornerRadius(20)
                        .padding(.bottom, 35)
                    VStack(spacing:20){
                        TextField("User Name eingeben", text: $userIdInput)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding(3)
                            .background(Color.darkDrivusBlue)
                            .cornerRadius(5)
                            .frame(width: 280)
                        
                        Button(action: {
                            viewModel_user.setLoginUser(userIdInput)
                            sent = true
                        }) {
                            Text("einloggen")
                                .foregroundColor(.white)
                                .padding(.horizontal,10)
                                .padding(.vertical,10)
                                .background(Color.darkDrivusBlue)
                                .cornerRadius(20)
                        }
                    }
                    
                }
                .padding()
            }else{
                
                
                VStack {
                    
                    //buttons
                    VStack{
                        Button(action: {viewModel_user.setLoginUser(Model.UserModel.DefaultUser.default.id)
                            sent = false
                        }) {
                            Text("ausloggen")
                                .foregroundColor(.darkDrivusBlue)
                                .padding(6)
                                .background(Color.white)
                                .cornerRadius(8)
                        }.shadow(color: .darkDrivusBlue, radius: 2, y: 2).padding(.trailing, 250).padding(.top,-50)
                        
                        Image("\(viewModel_user.loggedUser.name)")
                            .resizable()
                            .frame(width: 150, height: 150)
                            .background(Color.drivusBlue)
                            .foregroundColor(.white)
                            .clipShape(Circle())
                            .padding(.top,-20)
                            .padding(.bottom,0)
                        
                        Text("\(viewModel_user.loggedUser.name)")
                            .padding(6)
                            .padding(.horizontal,60)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .font(.largeTitle)
                        
                        Text("\(viewModel_user.loggedUser.zitat)")
                            .padding(.bottom,30)
                            .padding(.top,10)
                            .foregroundColor(.white)
                            .fontWeight(.light)
                    }.background(
                        Image("Userback")
                            .resizable()
                            .frame(width: 400, height: 430)
                    )
                    
                    
                    VStack(spacing: 10) {
                        Text("Alter: \(viewModel_user.loggedUser.age)")
                            .padding(10)
                            .background(Color.darkDrivusBlue)
                            .foregroundColor(.white)
                            .shadow(color: .black, radius: 10, y: 10)
                            .cornerRadius(10)
                            .font(.subheadline)
                            .frame(width: 1000)

                        
                        Text("Wohnort: \(viewModel_user.loggedUser.wohnort)")
                            .padding(10)
                            .background(Color.darkDrivusBlue)
                            .foregroundColor(.white)
                            .shadow(color: .black, radius: 10, y: 10)
                            .cornerRadius(10)
                            .font(.subheadline)
                            .frame(width: 1000)
                        
                        Text("Fahrer: \(viewModel_user.loggedUser.driver ? "Ja" : "Nein")")
                            .padding(10)
                            .background(Color.darkDrivusBlue)
                            .foregroundColor(.white)
                            .shadow(color: .black, radius: 10, y: 10)
                            .cornerRadius(10)
                            .font(.subheadline)
                            .frame(width: 1000)

                    }
                    .padding(.top, 100)
                    
                    // check or x
                    
                    
                }
            }
        }
        
    }
}
