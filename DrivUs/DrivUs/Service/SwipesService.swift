//
//  SwipesService.swift
//  DrivUs
//
//  Created by Natalie Schmitzberger on 21.05.24.
//

import Foundation

class SwipesService {
    static let shared = SwipesService()
    
    func fetchSwipes(completion: @escaping ([SwipeObject]?) -> Void) {
        guard let url = URL(string: "http://localhost:3000/swipes") else {
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
                let loadedSwipes = try JSONDecoder().decode([SwipeObject].self, from: data)
                completion(loadedSwipes)
            } catch {
                print("Error decoding posts: \(error)")
                completion(nil)
            }
        }.resume()
    }
}
