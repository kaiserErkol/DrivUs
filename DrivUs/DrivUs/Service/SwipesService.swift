//
//  SwipesService.swift
//  DrivUs
//
//  Created by Natalie Schmitzberger on 21.05.24.
//

import Foundation

class SwipesService {
    static let shared = SwipesService()
    
    func fetchAllSwipes(completion: @escaping ([Model.SwipeModel.Swipe]?) -> Void) {
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
                let loadedSwipes = try JSONDecoder().decode([Model.SwipeModel.Swipe].self, from: data)
                completion(loadedSwipes)
            } catch {
                print("Error decoding posts: \(error)")
                completion(nil)
            }
        }.resume()
    }
    
    func fetchSwipeById(byID swipeId: String, completion: @escaping (Model.SwipeModel.Swipe?) -> Void) {
        guard var urlComponents = URLComponents(string: "http://localhost:3000/swipes") else {
            completion(nil)
            return
        }
        
        // Append the ride ID as a query parameter
        urlComponents.queryItems = [URLQueryItem(name: "id", value: swipeId)]
        
        guard let url = urlComponents.url else {
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
                let loadedSwipe = try JSONDecoder().decode(Model.SwipeModel.Swipe.self, from: data)
                completion(loadedSwipe)
            } catch {
                print("Error decoding swipe: \(error)")
                completion(nil)
            }
        }.resume()
    }
}
