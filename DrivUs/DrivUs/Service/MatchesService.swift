//
//  MatchesService.swift
//  DrivUs
//
//  Created by MacBook on 30.04.24.
//

import Foundation

class MatchesService {
    static let shared = MatchesService()
    
    func fetchMatches(completion: @escaping ([MatchObject]?) -> Void) {
        guard let url = URL(string: "http://localhost:3000/matches") else {
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
                let loadedMatches = try JSONDecoder().decode([MatchObject].self, from: data)
                completion(loadedMatches)
            } catch {
                print("Error decoding posts: \(error)")
                completion(nil)
            }
        }.resume()
    }
}
