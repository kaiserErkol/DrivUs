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
            
            
            VStack {
                //buttons
                
                Image("\(viewModel_user.currUser.name)")
                    .resizable()
                    .frame(width: 220, height: 220)
                    .background(Color.drivusBlue)
                    .foregroundColor(.white)
                    .clipShape(Circle())
                    .shadow(color: .black, radius: 10)
                    .padding(.top,50)
                    .padding(.bottom,50)
                Text("\(viewModel_user.currUser.name)")
                    .padding(10)
                    .padding(.horizontal,80)
                    .background(.white)
                    .foregroundColor(.black)
                    .cornerRadius(10)
                    .font(.title)
                    .fontWeight(.light)
                Text("' \(viewModel_user.getCurrUser().zitat) '")
                    .padding(30)
                
                VStack(spacing:20){
                    Text("age: \(viewModel_user.getCurrUser().age)")
                        .padding(10)
                        .padding(.horizontal,100)
                        .background(.darkDrivusBlue)
                        .foregroundColor(.white)
                        .shadow(color: .black, radius: 10, y: 10)
                        .cornerRadius(10)
                        .font(.title)
                        .fontWeight(.ultraLight)
                    Text("wohnort: \(viewModel_user.getCurrUser().wohnort)")
                        .padding(10)
                        .padding(.horizontal,70)
                        .background(Color.darkDrivusBlue)
                        .foregroundColor(.white)
                        .shadow(color: .black, radius: 10, y: 10)
                        .cornerRadius(10)
                        .font(.title)
                        .fontWeight(.ultraLight)
                    Text("Driver: \(viewModel_user.getCurrUser().driver ? "Yes" : "No")")
                        .padding(10)
                        .padding(.horizontal,100)
                        .background(.darkDrivusBlue)
                        .foregroundColor(.white)
                        .shadow(color: .black, radius: 20, y: 10)
                        .cornerRadius(10)
                        .font(.title)
                        .fontWeight(.ultraLight)
                    
                }.frame(width: 400)

                // check or x
                
            }
            .foregroundColor(.white)
            .aspectRatio(contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
            .padding(150)
            .padding(.bottom,150)
            .padding(.top,100)
            .background(.drivusBlue)
            .frame(height: UIScreen.main.bounds.height*1.5)
            .ignoresSafeArea()
            .cornerRadius(20)
            .shadow(color: .white, radius: 15,x:-0,y:-5)
            .frame(width: UIScreen.main.bounds.width)
            
            
            Spacer()
                .task {
                    viewModel_user.fetchUsers()
                }
        }
    }
    }


#Preview {
    UserView()
}
