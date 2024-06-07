//
//  MatchesService.swift
//  DrivUs
//
//  Created by MacBook on 30.04.24.
//

import Foundation

class MatchesService {
    static let shared = MatchesService()
    
    func fetchAllMatches(completion: @escaping ([Model.MatchModel.Match]?) -> Void) {
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
                let loadedMatches = try JSONDecoder().decode([Model.MatchModel.Match].self, from: data)
                completion(loadedMatches)
            } catch {
                print("Error decoding posts: \(error)")
                completion(nil)
            }
        }.resume()
    }
    
    func createMatch(match: Model.MatchModel.Match, completion: @escaping (Bool) -> Void) {
        guard let url = URL(string: "http://localhost:3000/matches") else {
            completion(false)
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST" // Specify POST method
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            let jsonData = try JSONEncoder().encode(match)
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
     let newMatch = MatchObject(id: "123", userId: "456", rideId: "789")
     MatchesService.shared.createMatch(match: newMatch) { success in
         if success {
             print("Match created successfully")
         } else {
             print("Failed to create match")
         }
     }
     */
}
