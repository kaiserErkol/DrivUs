//
//  UserService.swift
//  DrivUs
//
//  Created by MacBook on 28.05.24.
//

import Foundation


class UserService {
    static let shared = UserService()
    
    func fetchAllUsers(completion: @escaping ([Model.UserModel.User]?) -> Void) {
        guard let url = URL(string: "http://localhost:3000/users") else {
            completion(nil)
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET" // Specify GET method
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error fetching posts: \(error)")
                completion(nil)
                return
            }
            
            guard let data = data else {
                completion(nil)
                return
            }
            
            do {
                let loadedUsers = try JSONDecoder().decode([Model.UserModel.User].self, from: data)
                
                completion(loadedUsers)
            } catch {
                print("Error decoding posts: \(error)")
                completion(nil)
            }
        }.resume()
    }
    
    func fetchUserById(byID userId: String, completion: @escaping (Model.UserModel.User?) -> Void) {
        // Create the URL with the swipe ID
        guard let url = URL(string: "http://localhost:3000/users/\(userId)") else {
            completion(nil)
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET" // Specify GET method
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error fetching swipe: \(error)")
                completion(nil)
                return
            }
            
            guard let data = data else {
                completion(nil)
                return
            }
            
            do {
                let loadedUser = try JSONDecoder().decode(Model.UserModel.User.self, from: data)
                completion(loadedUser)
            } catch {
                print("Error decoding swipe: \(error)")
                completion(nil)
            }
        }.resume()
    }
}


