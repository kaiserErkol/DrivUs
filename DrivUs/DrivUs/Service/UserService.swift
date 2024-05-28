//
//  UserService.swift
//  DrivUs
//
//  Created by MacBook on 28.05.24.
//

import Foundation

fileprivate let urlString = "http://localhost:3000/users"

class UserService {
    static let shared = UserService()
    
    func fetchUsers(completion: @escaping ([UserObject]?) -> Void) {
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
                let loadedUsers = try JSONDecoder().decode([UserObject].self, from: data)
                completion(loadedUsers)
            } catch {
                print("Error decoding posts: \(error)")
                completion(nil)
            }
        }.resume()
    }
}


