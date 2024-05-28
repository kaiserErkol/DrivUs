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
    
    func createSwipe(swipe: SwipeObject, completion: @escaping (Bool) -> Void) {
        guard let url = URL(string: "http://localhost:3000/swipes") else {
            completion(false)
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST" // Specify POST method
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            let jsonData = try JSONEncoder().encode(swipe)
            request.httpBody = jsonData
        } catch {
            print("Error encoding match: \(error)")
            completion(false)
            return
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error creating match: \(error)")
                completion(false)
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 201 else {
                completion(false)
                return
            }
            
            completion(true)
        }.resume()
    }
    /**
     USAGE:
     let newSwipe = SwipeObject(id: "123", userId: "456", rideId: "789")
     SwipesService.shared.createSwipe(swipe: newSipe) { success in
         if success {
             print("Swipe created successfully")
         } else {
             print("Failed to create Swipe")
         }
     }
     */
}
